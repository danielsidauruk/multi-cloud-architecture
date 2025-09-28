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
