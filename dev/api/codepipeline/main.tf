data "aws_codestarconnections_connection" "github-connection" {
  arn = "arn:aws:codestar-connections:us-east-1:527761931337:connection/6fe02db6-1aa0-4b19-a999-b545199d8435"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-us-east-1-752361780920"
  acl    = "private"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      configuration = {
        ConnectionArn        = data.aws_codestarconnections_connection.github-connection.arn
        FullRepositoryId     = var.github_repo_name
        BranchName           = "master"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        //        https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-ECS.html
        "ClusterName" : var.ecs_cluster_name
        "ServiceName" : var.ecs_service_name
        "FileName" : var.image_definition_file_path
        "DeploymentTimeout" : var.deployment_timeout
      }
    }
  }
}
