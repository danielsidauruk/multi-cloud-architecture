output "vpc_self_link" {
  description = "VPC self-link."
  value       = google_compute_network.main.self_link
}

output "vpc_name" {
  description = "VPC name."
  value       = google_compute_network.main.name
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs."
  value       = [for subnet in google_compute_subnetwork.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of Private Subnet IDs."
  value       = [for subnet in google_compute_subnetwork.private : subnet.id]
}