# General
variable "region" {
  description = "AWS region."
  type        = string
}

# VPC
variable "cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

variable "az_count" {
  description = "Number of AZs."
  type        = number
}

variable "vgw_id" {
  description = "AWS VPN Gateway ID."
  type        = string
}
