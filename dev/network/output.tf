output "network" {
  value = module.vpc
}

output "web_server_security_group_id" {
  value = aws_security_group.allow_8080.id
}

output "postgres_db_security_group_id" {
  value = aws_security_group.allow_5432.id
}

output "load_balancer_security_group_id" {
  value = aws_security_group.allow_80.id
}

