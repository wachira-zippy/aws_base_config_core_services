resource "aws_s3_bucket" "aws_config" {
  bucket        = "${company_name}-${environment}-config-bucket"
  force_destroy = true

  tags = {
    Name        = "${company_name}-${environment}-config-bucket"
      }
}

//allow config to send logs to the bucket
resource "aws_s3_bucket_policy" "aws_config" {
bucket = aws_s3_bucket.aws_config.id
depends_on = [aws_s3_bucket.aws_config]

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "config.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::"${company_name}-${environment}-config-bucket""
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "config.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::"${company_name}-${environment}-config-bucket"/config/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_versioning" "aws_config" {
  bucket = aws_s3_bucket.aws_config.id
  depends_on = [aws_s3_bucket.aws_config]

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_config" {
  bucket = aws_s3_bucket.aws_config.id
  depends_on = [aws_s3_bucket.aws_config]

  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
}

resource "aws_s3_bucket_acl" "aws_config" {
  bucket = aws_s3_bucket.aws_config.id
  depends_on = [aws_s3_bucket.aws_config]
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "aws_config" {
  bucket = aws_s3_bucket.aws_config.id
  depends_on = [aws_s3_bucket.aws_config]

  rule {
    id = "Expire in ${var.config_lifecycle_bucket} Days"
    expiration {
      days = var.config_lifecycle_bucket
    }

    noncurrent_version_expiration {
      noncurrent_days = var.config_lifecycle_bucket
    }

    status = "Enabled"
  }
}

//load module with base for AWS Config
module "config" {
  source                        = "./aws_config"
  is_enabled                    = true
  config_name                   = var.config_name
  config_logs_bucket            = aws_s3_bucket.aws_config.bucket
  config_logs_prefix            = "config"
  config_delivery_frequency     = "Six_Hours"
  include_global_resource_types = true
}
