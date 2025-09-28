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
