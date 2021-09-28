data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:us-east-1:527761931337:secret:codebuild/github_token-5Lllge"
}

data "aws_secretsmanager_secret_version" "this" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}

locals {
  token = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)["personal_access_token"]
}

resource "aws_codebuild_source_credential" "this" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = local.token
}

module "master_project" {
  source                     = "./project"
  codebuild_project_name     = "${var.codebuild_project_name}--master"
  project_description        = var.project_description
  codebuild_service_role_arn = coalesce(var.codebuild_service_role_arn, aws_iam_role.codebuild_role.arn)
  github_url                 = var.github_url
  buildspec_file_name        = "buildspec.master.yaml"
  vpc_config = var.vpc_config
}

module "master_hook" {
  source                 = "./project/master"
  codebuild_project_name = module.master_project.codebuild_project_name
}

module "branch_project" {
  source                     = "./project"
  codebuild_project_name     = "${var.codebuild_project_name}--branch"
  project_description        = var.project_description
  codebuild_service_role_arn = coalesce(var.codebuild_service_role_arn, aws_iam_role.codebuild_role.arn)
  github_url                 = var.github_url
  buildspec_file_name        = "buildspec.branch.yaml"

  vpc_config = var.vpc_config
}

module "branch_hook" {
  source                 = "./project/branch"
  codebuild_project_name = module.branch_project.codebuild_project_name
}
