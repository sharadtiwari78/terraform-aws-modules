# Allows the CloudWatch event to assume roles
resource "aws_iam_role" "codepipeline_trigger_iam_role" {
  name = "${var.env}-${var.name}-iam-role"

  assume_role_policy = <<DOC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
DOC
}
data "aws_iam_policy_document" "codepipeline_iam_policy_documents" {
  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    # Allow CloudWatch to start the Pipeline
    actions = [
      "codepipeline:StartPipelineExecution"
    ]
    resources = [
      "*"
    ]
  }
}
resource "aws_iam_policy" "codepipeline_iam_policy" {
  name   = "${var.env}-${var.name}-iam-policy"
  policy = data.aws_iam_policy_document.codepipeline_iam_policy_documents.json
}
resource "aws_iam_role_policy_attachment" "iam_Policy_attachment" {
  policy_arn = aws_iam_policy.codepipeline_iam_policy.arn
  role       = aws_iam_role.codepipeline_trigger_iam_role.name
}