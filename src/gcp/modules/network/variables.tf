
variable "vpc_name" {
  description = "VPC network name "
  type        = string
}

variable "region" {
  description = "The region where the network and subnets will be created"
  type        = string
}

variable "az_count" {
  description = "The number of availability zones to use."
  type        = number
}

variable "cidr_block" {
  description = "VPC CIDR block."
  type        = string
}
