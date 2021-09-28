locals {
  snake_name       = "krishi_test_tf"
  dash_name        = "krishi-test-tf"
  project_name     = local.snake_name
  ecr_repo_name    = local.dash_name
  api_lb_name      = local.dash_name
  tg_name          = local.dash_name
}

module "ci_project_setup" {
  source                 = "./codebuild"
  codebuild_project_name = local.project_name
  project_description    = "Simple API to practice Terraform"
  github_url             = "https://github.com/krishisharma45/mock-api-terraform/"

  vpc_config = {
    vpc_id             = var.vpc_id
    subnets            = var.codebuild_subnet_ids
    security_group_ids = [var.codebuild_security_group_id]
  }

}

module "pipeline" {
  source = "./codepipeline"

  project_name           = local.project_name
  codebuild_project_name = module.ci_project_setup.master_project_name
  ecs_cluster_name       = var.aws_cluster.name
  ecs_service_name       = module.ecs_deploy.ecs_service_name
  github_repo_name       = "krishisharma45/mock-api-terraform"
}


module "docker_repo_to_push" {
  source               = "./ecr"
  ecr_docker_repo_name = local.ecr_repo_name
}

module "ecs_deploy" {
  source = "./ecs"

  cluster_resource            = var.aws_cluster
  docker_image_url            = module.docker_repo_to_push.image_url
  region                      = var.region
  task_definition_family_name = local.project_name
  task_container_name         = "krishi-test"     //local.project_name

  # Service Location
  service_allowable_subnets = var.service_subnets
  service_security_groups   = var.service_security_groups

  # Load balancer Location
  api_lb_name                   = local.api_lb_name
  tg_name                       = local.tg_name
  load_balancer_subnets         = var.load_balancer_subnets
  load_balancer_security_groups = var.load_balancer_security_groups

  target_group_vpc_id = var.vpc_id
}