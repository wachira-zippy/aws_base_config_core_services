provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.1"
    }
    awsutils = {
      source = "cloudposse/awsutils"
    }
  }
}
