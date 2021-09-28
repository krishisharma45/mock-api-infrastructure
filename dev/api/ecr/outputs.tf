output "image_url" {
  value       = aws_ecr_repository.ecr_repo.repository_url
  description = "The fully qualified URL to the docker repository for the service."
}
