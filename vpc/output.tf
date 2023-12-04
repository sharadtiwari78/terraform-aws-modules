#VPC Outputs
output "vpc_arn" {
  description = "The ARN of the ffng VPC"
  value       = aws_vpc.aws_vpc.arn
}

output "vpc_id" {
  description = "The ID of the ffng VPC"
  value       = aws_vpc.aws_vpc.id
}

# Internat Gateway Outputs
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.igw.id, null)
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(aws_internet_gateway.igw.arn, null)
}

# Public Subnet Outputs
output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public[*].cidr_block)
}

# Private Subnets Outputs
output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private[*].arn
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private[*].cidr_block)
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

# DB Subnets Outputs
output "db_subnet_ids" {
  description = "List of IDs of db subnets"
  value       = aws_subnet.db[*].id
}

output "db_subnets_arns" {
  description = "List of ARNs of db subnets"
  value       = aws_subnet.db[*].arn
}

output "db_subnets_cidr_blocks" {
  description = "List of cidr_blocks of db subnets"
  value       = compact(aws_subnet.db[*].cidr_block)
}

