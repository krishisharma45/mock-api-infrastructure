variable "security_group_ids" {
  description = "The security groups that allow inbound traffic into the database"
}

variable "private_subnets_ids" {
  description = "The list of private subnets that can be used for the database cluster"
}
