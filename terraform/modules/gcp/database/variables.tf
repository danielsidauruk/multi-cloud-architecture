variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "GCP Region."
  type        = string
}

variable "vpc_self_link" {
  description = "VPC Self Link."
  type        = string
}

variable "db_name" {
  description = "PostgreSQL Database Name."
  type        = string
}

variable "rds_instance_address" {
  description = "RDS Instance Address (Endpoint)."
  type        = string
}

variable "replication_user" {
  description = "Postgresql Replication User."
  type        = string
}

variable "replication_user_password" {
  description = "Postgresql Replication User Password."
  type        = string
}

variable "root_password" {
  description = "CloudSQL Root User Password."
  type        = string
  sensitive   = true
}
