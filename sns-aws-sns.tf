// this script sets up an encrypted SNS topic with an email endpoint for technical notifications. 
resource "aws_sns_topic" "topic" {
  name = "technical-alerts"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = var.sns_subscriber_email
}

// can choose to use an AWS-Managed key or a CMK. This script uses a CMK to enable CloudWatch to send notifications to the encrypted topic.

resource "aws_kms_key" "sns-key" {
  description             = "SNS topic key"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.kms_sns.json
}

resource "aws_kms_alias" "sns-key-alias"{
  name = "alias/sns-key"
  target_key_id = aws_kms_key.sns-key.id
}

data "aws_region" "current" {} //data source used to discover the name of the region configured in the provider.

//if sending notifications to SNS from CloudWatch, you need to set up permissions to allow CloudWatch to send notifications to the encrypted topic.
data "aws_iam_policy_document" "sns_policy" { 

  statement {
    sid = "Allow_CloudWatch_for_CMK"
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    resources = [
      "*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }
  }

  statement {
    sid = "Allow_Publish_Alarms "
    actions = [
      "sns:Publish"
    ]

    resources = [
      "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:technical-alerts" //update to name of your topic
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }

    condition {
      test = "ArnLike"
      variable = "aws:SourceArn"
      values = ["arn:aws:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alarm:*",]
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


