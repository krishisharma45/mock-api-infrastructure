variable "project_name" {
  type        = string
  description = "The name of the project you intend to stand up with CD"
}

variable "ecs_cluster_name" {
  description = "The ECS Cluster name"
}

variable "ecs_service_name" {
  description = "The ECS Service name"
}

variable "image_definition_file_path" {
  description = "The path to the image definitions file. Defaults to ./imagedefinitions.json"
  default     = "imagedefinitions.json"
}

variable "deployment_timeout" {
  description = "The time in minutes to spend waiting for the deployment to complete. Defaults to 15 minutes"
  default     = "15"
}

variable "codebuild_project_name" {
  type        = string
  description = "The codebuild project to attach to this Build stage in codepipeline"
}

variable "github_repo_name" {
  type        = string
  description = "The Github Name in the format of ORG/REPO_NAME (e.g. Clairity/tf-training-pipeline)"
}