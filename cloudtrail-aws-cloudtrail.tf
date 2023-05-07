data "aws_iam_policy_document" "kms" {
  version = "2012-10-17"

  statement {
    sid    = "enable iam user permissions"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "allow cloudtrail to encrypt logs"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }

  statement {
    sid    = "allow cloudTrail to describe key"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }

  statement {
    sid    = "allow principals in the account to decrypt log files"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = [
      "${data.aws_caller_identity.current.account_id}"]
    }

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }

  statement {
    sid    = "allow alias creation during setup"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:CreateAlias"]
    resources = ["*"]
  }
}

module "kms_key" {
  source                  = "./aws-kms"
  description             = "kms key for cloudtrail"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  alias                   = "alias/cloudtraillogs"
  policy                  = data.aws_iam_policy_document.kms.json
}

resource "aws_s3_bucket" "aws_cloudtrail" {
  bucket        = var.cloudtrail_bucket
  force_destroy = true

  tags = {
    Name        = var.cloudtrail_bucket
      }
}

resource "aws_s3_bucket_versioning" "aws_cloudtrail" {
  bucket = aws_s3_bucket.aws_cloudtrail.id
  depends_on = [aws_s3_bucket.aws_cloudtrail]

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_cloudtrail" {
  bucket = aws_s3_bucket.aws_cloudtrail.id
  depends_on = [aws_s3_bucket.aws_cloudtrail]

  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
}

resource "aws_s3_bucket_acl" "aws_cloudtrail" {
  bucket = aws_s3_bucket.aws_cloudtrail.id
  depends_on = [aws_s3_bucket.aws_cloudtrail]
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "aws_cloudtrail" {
  bucket = aws_s3_bucket.aws_cloudtrail.id
  depends_on = [aws_s3_bucket.aws_cloudtrail]

  rule {
    id = "Expire in 731 Days"
    expiration {
      days = 731
    }

    noncurrent_version_expiration {
      noncurrent_days = 731
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "aws_cloudtrail" {
bucket = aws_s3_bucket.aws_cloudtrail.id
depends_on = [aws_s3_bucket.aws_cloudtrail]

policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.cloudtrail_bucket}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.cloudtrail_bucket}/cloudtrail/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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

resource "aws_iam_role" "cloudwatch_role" {
  name = "cloud_trail_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name = "cloudwatch"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect : "Allow",
          Action : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents"
          ],
          Resource : [
            "*"
          ]
        },
      ]
    })
  }
}

module "log_group" {
  source            = "./aws-cloudwatch-loggroup"
  name              = var.cloudtrail_loggroup
  retention_in_days = 365
  kms_key_id        = module.kms_key.key_arn
}

module "cloudtrail" {
  source                        = "./aws-cloudtrail"
  name                          = "cloudtraillogs"
  enable_logging                = true
  s3_bucket_name                = aws_s3_bucket.aws_cloudtrail.id
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  include_global_service_events = true
  cloud_watch_logs_role_arn     = aws_iam_role.cloudwatch_role.arn
  cloud_watch_logs_group_arn    = module.log_group.cloudwatch_log_group_arn
  kms_key_id                    = module.kms_key.key_arn
  s3_key_prefix                 = "cloudtrail"
}
