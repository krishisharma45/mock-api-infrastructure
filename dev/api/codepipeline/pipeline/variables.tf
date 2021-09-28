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
  default     = "imagedefinitions.json"
  description = "The path to the image definitions file. Defaults to ./imagedefinitions.json"
}

variable "deployment_timeout" {
  default     = "15"
  description = "The time in minutes to spend waiting for the deployment to complete. Defaults to 15 minutes"
}

variable "codebuild_project_name" {
  type        = string
  description = "The codebuild project to attach to this Build stage in codepipeline"
}
