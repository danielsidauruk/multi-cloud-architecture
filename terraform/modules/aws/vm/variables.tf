variable "vpc_id" {
  description = "AWS VPC ID."
  type        = string
}

variable "cidr_block" {
  description = "CIDR Block."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of Public Subnet IDs."
  type        = list(string)
}

variable "key_name" {
  description = "AWS Key Pair for ssh to VM."
  type        = string
}