variable "name" {
  type        = string
  description = "cloudwatch event rule name"
}

variable "env" {
  type = string
}

variable "schedule_expression" {
  description = "cloudwatch event schedule expression"
}

variable "codepipeline_arn" {}
