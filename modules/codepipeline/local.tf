locals {
    pipeline = [
      {
        name = "Source"
        action = [{
          name             = "Source"
          category         = "Source"
          owner            = "AWS"
          provider         = "CodeCommit"
          version          = "1"
          output_artifacts = ["source_output"]
          run_order        = 1

          configuration = {
            RepositoryName       = var.repository_name
            BranchName           = var.branch_name
            PollForSourceChanges = var.pipe_auto_run
          }
        }]
      },
      {
        name = "${var.env}-Build"
        enabled = var.build_enabled 
        action = [{
          name             = "Build"
          category         = "Build"
          owner            = "AWS"
          provider         = "CodeBuild"
          input_artifacts  = ["source_output"]
          output_artifacts = ["build_output"]
          version          = "1"
          run_order        = 2

          configuration = {
            ProjectName = var.build_project_name
          }
        }]
      },
      {
        name = "${var.env}-Deploy"
        action = [{
          name            = "Deploy"
          category        = "Deploy"
          owner           = "AWS"
          provider        = "CodeDeploy"
          input_artifacts = ["build_output"]
          version         = "1"
          run_order       = 3

          configuration = {
            ApplicationName     = var.application_name
            DeploymentGroupName = var.deployment_group_name
          }
        }]
      }
    ]
  artifact_store = {
    location = "${var.env}-codepipeline-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
    type     = "S3"
  }
  force_destroy = true
}
