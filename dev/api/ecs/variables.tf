variable "cluster_resource" {
  description = "ECS Cluster name"
}

variable "api_lb_name" {
  description = "API Load Balancer Name"
}

variable "tg_name" {
  description = "Target Group Name"
}

variable "region" {
  description = "AWS Region to build the resources - e.g. us-gov-west-1"
}

# Service Configuration
variable "service_security_groups" {
  description = "Security Group name used to deploy this service"
  type        = list(string)
}

variable "service_allowable_subnets" {
  description = "A list of subnet names that the service may provision tasks under"
  type        = list(string)
}

# Task configuration
variable "task_container_name" {
  description = "The name of the container when running as a task in ECS"
  type        = string
}

variable "task_definition_family_name" {
  description = "The ECS Task Definition name"
  type        = string
}

variable "docker_image_url" {
  description = "Docker Image URL that the ECS task will pull down for the service"
  type        = string
}

variable "memory_value" {
  type        = number
  default     = 512
  description = "The memory value to apply to a task for how much it likely needs to function. e.g. 512, 1024, 2048. Must be in range of cpu unit values"
}

variable "cpu_unit" {
  type        = number
  default     = 256
  description = "The cpu unit to apply to a task for much it needs to function. e.g. 256(.25vCPU), 512(.5vCPU), 1024(1 CPU)"
}

variable "task_role_arn" {
  type        = string
  description = "The Role of the Application when you deploy. If you do not add a permission here, the application cannot ask for anything from an AWS service."
  default     = ""
}

variable "execution_role_arn" {
  type        = string
  description = "The ECS Execution while provisoning and deploying your service. This must have roles to pull and manipulate ECR in order to function."
  default     = ""
}

# Load balancer variables
variable "load_balancer_subnets" {
  type = list(string)
}

variable "load_balancer_security_groups" {
  description = "Security Groups that the load balancer will use to accept or reject traffic"
  type        = list(string)
}

variable "target_group_vpc_id" {
  description = "This would be the VPC you want the load balancer to map traffic to"
  type        = string
}

variable "desired_task_count" {
  default     = 1
  type        = number
  description = "The desired count of tasks when we deploy the service. Defaults to 1"
}
