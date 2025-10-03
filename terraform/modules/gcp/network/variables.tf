variable "vpc_name" {
  description = "VPC network name "
  type        = string
}

variable "region" {
  description = "GCP Region."
  type        = string
}

variable "subnet_count" {
  description = "Number of subnet(s)."
  type        = number
}

variable "cidr_block" {
  description = "VPC CIDR block."
  type        = string
}
