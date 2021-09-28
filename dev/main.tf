terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.36.0"
    }
  }

  backend "s3" {
    bucket = "practice-terraform-kskf"
    key = "all"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "./network"
  env = "dev"
}

resource "aws_ecs_cluster" "cluster" {
  name = "krishi-test-tf"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

module "krishi-test-db" {
  source              = "./databases"
  private_subnets_ids = module.networking.network.private_subnets
  security_group_ids  = [module.networking.postgres_db_security_group_id]
}

module "api" {
  source              = "./api"

  aws_cluster = aws_ecs_cluster.cluster

  region                      = "us-east-1"
  vpc_id                      = module.networking.network.vpc_id
  codebuild_security_group_id = module.networking.web_server_security_group_id
  codebuild_subnet_ids        = module.networking.network.private_subnets

  load_balancer_security_groups = [module.networking.load_balancer_security_group_id]
  load_balancer_subnets         = module.networking.network.public_subnets

  service_subnets         = module.networking.network.public_subnets
  service_security_groups = [module.networking.web_server_security_group_id]
}