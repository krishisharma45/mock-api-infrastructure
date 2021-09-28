resource "aws_codebuild_project" "this" {
  name          = var.codebuild_project_name
  description   = var.project_description
  badge_enabled = true
  build_timeout = "60"
  service_role  = var.codebuild_service_role_arn

  vpc_config {
    vpc_id             = var.vpc_config.vpc_id
    subnets            = var.vpc_config.subnets
    security_group_ids = var.vpc_config.security_group_ids
  }

  source {
    type                = "GITHUB"
    location            = var.github_url
    git_clone_depth     = 1
    buildspec           = var.buildspec_file_name
    report_build_status = true

    git_submodules_config {
      fetch_submodules = true
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  tags = {
    Terraform = true
  }
}