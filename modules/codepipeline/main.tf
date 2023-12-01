#create codepipeline
resource "aws_codepipeline" "Codepipeline" {
  name     = "${var.env}-${var.codepipeline_name}"
  role_arn = aws_iam_role.Codepipeline_iam_role.arn

  artifact_store {
    location = local.artifact_store["location"]
    type     = local.artifact_store["type"]
  }
  dynamic "stage" {
    for_each = [for s in local.pipeline : {
      name   = s.name
      action = s.action
    } if(lookup(s, "enabled", true))]

    content {
      name = stage.value.name
      dynamic "action" {
        for_each = stage.value.action
        content {
          name             = action.value["name"]
          owner            = action.value["owner"]
          version          = action.value["version"]
          category         = action.value["category"]
          provider         = action.value["provider"]
          input_artifacts  = lookup(action.value, "input_artifacts", [])
          output_artifacts = lookup(action.value, "output_artifacts", [])
          run_order        = lookup(action.value, "run_order", null)
          configuration    = lookup(action.value, "configuration", {})
          role_arn         = lookup(action.value, "role_arn", null)
        }
      }
    }
  }
}

#create s3 bucket for codepipeline artifact
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = local.artifact_store.location
  force_destroy  = local.force_destroy
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_acl" {
  bucket                  = aws_s3_bucket.codepipeline_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


