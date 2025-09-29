
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }

  backend "gcs" {}
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
