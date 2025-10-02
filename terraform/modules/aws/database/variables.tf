variable "private_subnet_ids" {
  description = "The Private Subnet IDs."
  type        = list(string)
}

variable "vpc_id" {
  description = "AWS VPC ID."
  type        = string
}

variable "cidr_block" {
  description = "CIDR Block."
  type        = string
}

variable "db_name" {
  description = "PostgreSQL Database Name."
  type        = string
}

variable "db_username" {
  description = "PostgreSQL Default Username"
  type        = string
}

variable "db_username_password" {
  description = "Postgresql Default Username Password"
  type        = string
  sensitive   = true
}