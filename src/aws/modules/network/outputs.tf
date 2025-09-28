output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "availability_zones" {
  description = "VPC Availability Zones."
  value       = local.azs_random
}
