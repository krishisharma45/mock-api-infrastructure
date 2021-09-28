variable "codebuild_project_name" {
  type        = string
  description = "Name of the build project"
}

variable "github_url" {
  type        = string
  description = "The github url to the repo you want to use. Must end in .git"
}

variable "project_description" {
  type        = string
  description = "Codebuild Project Description"
}

variable "codebuild_service_role_arn" {
  type        = string
  description = "The service role to use [as an ARN]"
}

variable "buildspec_file_name" {
  type        = string
  description = "The buildspec filename [e.g. buildspec.master.yml]"
  default     = "buildspec.master.yml"
}

variable "vpc_config" {
  type = object({
    security_group_ids = set(string),
    subnets            = set(string),
    vpc_id             = string
  })
}

variable "compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  default = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}
