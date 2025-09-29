
output "vpc_self_link" {
  description = "VPC self-link."
  value       = google_compute_network.main.self_link
}
