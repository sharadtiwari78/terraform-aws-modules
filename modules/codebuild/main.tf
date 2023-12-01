#create codebuild project for preprod
resource "aws_codebuild_project" "codebuild_project" {
  name          = "${var.env}-${var.build_project_name}"
  description   = "${var.env}-${var.build_project_name}"
  build_timeout = local.codebuild_timeout
  service_role  = aws_iam_role.codebuild_iam_role.arn

  artifacts {
    type = local.artifacts_type

  }

  environment {
    compute_type                = local.compute_type
    image                       = local.image
    type                        = local.type
    image_pull_credentials_type = local.image_pull_credentials_type
  }
  logs_config {
    cloudwatch_logs {
      group_name  = "${var.env}-build-logs-group"
      stream_name = "${var.env}-build-stream"
    }
  }
  source {
    type      = local.source_type
    buildspec = local.buildspec
  }
}
