#==============================================================================
# General Configuration
#==============================================================================
variable "cidr_block" {
  description = "CIDR Block."
  type        = string
}

#==============================================================================
# PostgreSQL Configuration
#==============================================================================
variable "db_name" {
  description = "PostgreSQL Database Name."
  type        = string
}

variable "replication_user" {
  description = "PostgreSQL replication_user User."
  type        = string
}

variable "replication_user_password" {
  description = "PostgreSQL replication_user User Password."
  type        = string
}

#==============================================================================
# AWS Configuration
#==============================================================================
variable "aws_region" {
  description = "AWS Region."
  type        = string
}

variable "az_count" {
  description = "Count of Available Zone(s)."
  type        = number
}

variable "aws_profile" {
  description = "AWS Profile."
  type        = string
}

variable "aws_asn" {
  description = "AWS BGP ASN."
  type        = number
}

variable "key_name" {
  description = "AWS Key Pair for ssh to VM."
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

#==============================================================================
# GCP Configuration
#==============================================================================
variable "gcp_project_id" {
  description = "GCP Project ID."
  type        = string
}

variable "subnet_count" {
  description = "Number of subnet(s)."
  type        = number
}

variable "gcp_region" {
  description = "GCP Region."
  type        = string
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
}

variable "gcp_asn" {
  description = "GCP Router BGP ASN."
  type        = number
}

variable "root_password" {
  description = "CloudSQL Root User Password."
  type        = string
  sensitive   = true
}
