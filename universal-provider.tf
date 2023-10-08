//this script configures the provider. This script is for an AWS Provider. Update TF version to latest.


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
      source = "cloudposse/awsutils" //provider that allows you to delete all default VPCs in all regions. Not currently supported by Terraform.
    }
  }
}
