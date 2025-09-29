# General
variable "region" {
  description = "The primary AWS region."
  type        = string
}

# VPC
variable "cidr_block" {
  type        = string
  description = "The CIDR block of the VPC where resources will be deployed."
}

variable "az_count" {
  description = "Number of AZs."
  type        = number
}

variable "aws_vpn_gateway" {
  description = "AWS Virtual VPN Gateway"
  type        = string
}
# variable "aws_asn" {
#   description = "AWS BGP ASN"
#   type        = number
# }

# variable "gcp_vpn_interfaces" {
#   description = "Google Cloud HA VPN Interfaces public-ip"
#   type        = list(string)
# }

# variable "gcp_asn" {
#   description = "GCP Router BGP ASN"
#   type        = number
# }