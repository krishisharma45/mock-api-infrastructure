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
  default     = ""
}

variable "vpc_config" {
  type = object({
    security_group_ids = set(string),
    subnets            = set(string),
    vpc_id             = string
  })
}

variable "vpc_id" {
  type        = string
  description = "The VPC to relate codebuild-provisioned resources. Required to speak to internal resources like EFS during a build."
  default     = null
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The subnet(s) to apply to codebuild. Cannot use public subnets (subnets that have igw routes). Must only be private (subnets that have nat gateway routes)."
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "The list of security group ids that codebuild will use to speak to the internet. Ensure this is configured to speak to your internal vpc resources, if you desire such connectivity."
  default     = null
}

variable "efs_id" {
  type        = string
  description = "The EFS Filesystem ID to attach to this codebuild instance. VPC configurations become required if you apply an EFS."
  default     = null
}
