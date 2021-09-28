output "codebuild_role_arn" {
  value       = aws_iam_role.codebuild_role.arn
  description = "Codebuild Role Arn for this project"
}

output "master_project_name" {
  value = module.master_project.codebuild_project_name
}
