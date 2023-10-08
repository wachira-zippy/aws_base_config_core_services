
//this script enables the guardduty detector
resource "aws_guardduty_detector" "detector" {
  enable = true
}

resource "aws_guardduty_publishing_destination" "guard_duty_logs" {
  detector_id     = aws_guardduty_detector.detector.id
  destination_arn = aws_s3_bucket.guard_duty_s3_bucket.arn
  kms_key_arn     = aws_kms_key.guard_duty_key.arn //encrypt findings 

  depends_on = [
    aws_s3_bucket_policy.guard_duty_bucket_policy,
  ]
}

resource "aws_s3_bucket" "guard_duty_s3_bucket" {
  bucket = var.guard_duty_bucket // bucket name picked from the universal variables file.
  
  tags = {
    Name        = var.guard_duty_bucket
      }
}

resource "aws_s3_bucket_versioning" "guard_duty_s3_bucket" {
  bucket = aws_s3_bucket.guard_duty_s3_bucket.id
  depends_on = [aws_s3_bucket.guard_duty_s3_bucket]

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "guard_duty_s3_bucket" {
  bucket = aws_s3_bucket.guard_duty_s3_bucket.id
  depends_on = [aws_s3_bucket.guard_duty_s3_bucket]

  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }

}

resource "aws_s3_bucket_acl" "guard_duty_s3_bucket" {
  bucket = aws_s3_bucket.guard_duty_s3_bucket.id
  depends_on = [aws_s3_bucket.guard_duty_s3_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "guard_duty_s3_bucket" {
  bucket = aws_s3_bucket.guard_duty_s3_bucket.id
  depends_on = [aws_s3_bucket.guard_duty_s3_bucket]

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

resource "aws_s3_bucket_policy" "guard_duty_bucket_policy" {
  bucket = aws_s3_bucket.guard_duty_s3_bucket.id
  policy = data.aws_iam_policy_document.guard_duty_bucket_pol.json
}

//can optionally set up an alias for the key to make it easier to locate. The alias would also come in handy if you need to conform to a naming convention
resource "aws_kms_key" "guard_duty_key" {
  description             = "Guard Duty Key"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.kms_guard_duty_policy.json
}

data "aws_region" "current" {}

data "aws_iam_policy_document" "guard_duty_bucket_pol" {
  statement {
    sid = "Allow PutObject"
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.guard_duty_s3_bucket.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow GetBucketLocation"
    actions = [
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.guard_duty_s3_bucket.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "kms_guard_duty_policy" {

  statement {
    sid = "Allow GuardDuty to encrypt findings"
    actions = [
      "kms:GenerateDataKey"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow all users to modify/delete key"
    actions = [
      "kms:*"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
