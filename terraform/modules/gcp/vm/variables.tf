variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "vpc_name" {
  description = "GCP VPC name"
  type        = string
}

variable "cidr_block" {
  description = "CIDR Block"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of Public Subnet IDs"
  type        = list(string)
}

# variable "private_subnet" {
#   description = "The name of the private subnet."
#   type        = string
# }