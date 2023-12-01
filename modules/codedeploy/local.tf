locals {
  ec2_key                           = "Name"
  ec2_type                          = "KEY_AND_VALUE"
  auto_rollback_configuration_event = ["DEPLOYMENT_FAILURE"]
  deployment_config_name            = "CodeDeploy_AllatOnce"
  minimum_healthy_hosts_type        = "HOST_COUNT"
  minimum_healthy_hosts_value       = "0"
  deployment_group_name             = "deployment_group"
  application_name                  = "application"
}