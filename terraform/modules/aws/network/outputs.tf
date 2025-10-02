output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "availability_zones" {
  description = "VPC Availability Zones."
  value       = [for az in data.aws_availability_zones.available.names : az]
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of Private Subnet IDs."
  value       = [for subnet in aws_subnet.private : subnet.id]
}