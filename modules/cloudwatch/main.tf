resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = "${var.env}-${var.name}"

  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  arn       = var.codepipeline_arn
  role_arn  = aws_iam_role.codepipeline_trigger_iam_role.arn
}