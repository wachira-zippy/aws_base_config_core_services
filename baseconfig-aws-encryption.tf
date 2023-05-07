data "aws_kms_key" "backup" {
  key_id = "alias/aws/backup"
}

data "aws_caller_identity" "current" {
}

data "aws_kms_key" "ebs" {
  key_id = "alias/aws/ebs"
}

resource "aws_ebs_default_kms_key" "default" {
  key_arn = data.aws_kms_key.ebs.arn
}

resource "aws_ebs_encryption_by_default" "default" {
  enabled = true
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
}

resource "aws_ebs_encryption_by_default" "default-us-east-1" {
  enabled = true
  provider = aws.us-east-1
}

provider "aws" {
  region = "us-east-2"
  alias = "us-east-2"
}

resource "aws_ebs_encryption_by_default" "default-us-east-2" {
  enabled = true
  provider = aws.us-east-2
}

provider "aws" {
  region = "us-west-1"
  alias = "us-west-1"
}

resource "aws_ebs_encryption_by_default" "default-us-west-1" {
  enabled = true
  provider = aws.us-west-1
}

provider "aws" {
  region = "us-west-2"
  alias = "us-west-2"
}

resource "aws_ebs_encryption_by_default" "default-us-west-2" {
  enabled = true
  provider = aws.us-west-2
}

provider "aws" {
  region = "ap-south-1"
  alias = "ap-south-1"
}

resource "aws_ebs_encryption_by_default" "default-ap-south-1" {
  enabled = true
  provider = aws.ap-south-1
}

provider "aws" {
  region = "ap-northeast-3"
  alias = "ap-northeast-3"
}

resource "aws_ebs_encryption_by_default" "default-ap-northeast-3" {
  enabled = true
  provider = aws.ap-northeast-3
}

provider "aws" {
  region = "ap-northeast-2"
  alias = "ap-northeast-2"
}

resource "aws_ebs_encryption_by_default" "default-ap-northeast-2" {
  enabled = true
  provider = aws.ap-northeast-2
}

provider "aws" {
  region = "ap-southeast-1"
  alias = "ap-southeast-1"
}

resource "aws_ebs_encryption_by_default" "default-ap-southeast-1" {
  enabled = true
  provider = aws.ap-southeast-1
}

provider "aws" {
  region = "ap-southeast-2"
  alias = "ap-southeast-2"
}

resource "aws_ebs_encryption_by_default" "default-ap-southeast-2" {
  enabled = true
  provider = aws.ap-southeast-2
}

provider "aws" {
  region = "ap-northeast-1"
  alias = "ap-northeast-1"
}

resource "aws_ebs_encryption_by_default" "ap-northeast-1" {
  enabled = true
  provider = aws.ap-northeast-1
}

provider "aws" {
  region = "ca-central-1"
  alias = "ca-central-1"
}

resource "aws_ebs_encryption_by_default" "ca-central-1" {
  enabled = true
  provider = aws.ca-central-1
}

provider "aws" {
  region = "eu-central-1"
  alias = "eu-central-1"
}

resource "aws_ebs_encryption_by_default" "eu-central-1" {
  enabled = true
  provider = aws.eu-central-1
}

provider "aws" {
  region = "eu-west-1"
  alias = "eu-west-1"
}

resource "aws_ebs_encryption_by_default" "eu-west-1" {
  enabled = true
  provider = aws.eu-west-1
}

provider "aws" {
  region = "eu-west-2"
  alias = "eu-west-2"
}

resource "aws_ebs_encryption_by_default" "eu-west-2" {
  enabled = true
  provider = aws.eu-west-2
}

provider "aws" {
  region = "eu-west-3"
  alias = "eu-west-3"
}

resource "aws_ebs_encryption_by_default" "eu-west-3" {
  enabled = true
  provider = aws.eu-west-3
}

provider "aws" {
  region = "eu-north-1"
  alias = "eu-north-1"
}

resource "aws_ebs_encryption_by_default" "eu-north-1" {
  enabled = true
  provider = aws.eu-north-1
}

provider "aws" {
  region = "sa-east-1"
  alias = "sa-east-1"
}

resource "aws_ebs_encryption_by_default" "sa-east-1" {
  enabled = true
  provider = aws.sa-east-1
}
