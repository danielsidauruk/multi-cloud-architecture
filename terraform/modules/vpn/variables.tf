# AWS Configuration
variable "gcp_vpc_self_link" {
  description = "The name of the GCP VPC network."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region."
  type        = string
}

variable "gcp_asn" {
  description = "GCP Router BGP ASN"
  type        = number
}

# GCP Configuration
variable "aws_vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

variable "aws_asn" {
  description = "AWS Router BGP ASN"
  type        = number
}
