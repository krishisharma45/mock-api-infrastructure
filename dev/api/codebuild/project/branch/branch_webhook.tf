resource "aws_codebuild_webhook" "branch" {
  project_name = var.codebuild_project_name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type                    = "HEAD_REF"
      pattern                 = "refs/heads/master"
      exclude_matched_pattern = true
    }

    filter {
      type                    = "HEAD_REF"
      pattern                 = "refs/heads/main"
      exclude_matched_pattern = true
    }
  }
}
