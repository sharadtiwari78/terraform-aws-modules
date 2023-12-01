locals {
  source_type                 = "CODEPIPELINE"
  buildspec                   = "buildspec.yml"
  artifacts_type              = "CODEPIPELINE"
  codebuild_timeout           = "60"
  image_pull_credentials_type = "CODEBUILD"
  compute_type                = "BUILD_GENERAL1_MEDIUM"
  image                       = "aws/codebuild/windows-base:2019-2.0"
  type                        = "WINDOWS_SERVER_2019_CONTAINER"
}