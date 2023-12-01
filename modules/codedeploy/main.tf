#create codedeploy application
resource "aws_codedeploy_app" "codedeploy_app" {
  name = "${var.env}-${local.application_name}"
}
# create codedeploy deployment group
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  app_name               = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name  = "${var.env}-${local.deployment_group_name}"
  service_role_arn       = aws_iam_role.codedeploy_iam_role.arn
  deployment_config_name = aws_codedeploy_deployment_config.codedeploy_deployment_config.id

  ec2_tag_set {
    ec2_tag_filter {
      key   = local.ec2_key
      type  = local.ec2_type
      value = var.ec2_value
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = local.auto_rollback_configuration_event
  }
}
# create codedeploy deployment config for server
resource "aws_codedeploy_deployment_config" "codedeploy_deployment_config" {
  deployment_config_name = "${var.env}${local.deployment_config_name}"

  minimum_healthy_hosts {
    type  = local.minimum_healthy_hosts_type
    value = local.minimum_healthy_hosts_value
  }
}
