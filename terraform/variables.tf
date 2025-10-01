#==============================================================================
# General Configuration
#==============================================================================
variable "cidr_block" {
  description = "CIDR Block"
  type        = string
}

variable "az_count" {
  description = "Count of Available Zone"
  type        = number
}

#==============================================================================
# AWS Configuration
#==============================================================================
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_profile" {
  description = "AWS Profile"
  type        = string
}

variable "aws_asn" {
  description = "AWS BGP ASN"
  type        = number
}

variable "key_name" {
  description = "AWS Key Pair for ssh to VM"
  type        = string
}

#==============================================================================
# GCP Configuration
#==============================================================================
variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
}

variable "gcp_asn" {
  description = "GCP Router BGP ASN"
  type        = number
}
