# Define variables
variable "vpc_cidr" {
  description = "vpc 01 cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnet" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "db_subnet" {
  description = "A list of db subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "env" {
  type = string
}

