resource "aws_cloudwatch_metric_alarm" "login_failures_cloudtrail_changes" {
  alarm_name                = "CloudTrailChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.cloudtrail_changes.id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "3"
  alarm_description         = "Monitoring changes to CloudTrail's configuration will help ensure sustained visibility to activities performed in the AWS account."
  alarm_actions             = [aws_sns_topic.topic.arn]
  ok_actions                = [aws_sns_topic.topic.arn]
  treat_missing_data        = "missing"
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "login_failure" {
  name           = "ConsoleSigninFailures"
  pattern        = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
  log_group_name = var.cloudtrail_loggroup

  metric_transformation {
    name      = "ConsoleSigninFailures"
    namespace = var.alarm_namespace
    value     = "1"
  }

  depends_on = [
    module.log_group
  ]
}

resource "aws_cloudwatch_metric_alarm" "login_failure" {
  alarm_name                = "ConsoleSigninFailures"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.login_failure.id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "3"
  alarm_description         = "Monitoring failed console logins may decrease lead time to detect an attempt to brute force a credential, which may provide an indicator, such as source IP, that can be used in other event correlation."
  alarm_actions             = [aws_sns_topic.topic.arn]
  ok_actions                = [aws_sns_topic.topic.arn]
  treat_missing_data        = "missing"
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "unauthorized_apicalls_alarm" {
  name           = "UnauthorizedAttemptCount"
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
  log_group_name = var.cloudtrail_loggroup

  metric_transformation {
    name      = "UnauthorizedAttemptCount"
    namespace = var.alarm_namespace
    value     = "1"
  }

  depends_on = [
    module.log_group
  ]
}

resource "aws_cloudwatch_metric_alarm" "unauthorized_apicalls_alarm" {
  alarm_name                = "UnauthorizedAPICalls"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.unauthorized_apicalls_alarm.id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "10"
  alarm_description         = "A CloudWatch Alarm that triggers if Multiple unauthorized actions or logins attempted."
  alarm_actions             = [aws_sns_topic.topic.arn]
  ok_actions                = [aws_sns_topic.topic.arn]
  treat_missing_data        = "missing"
  insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "root_usage_alarm" {
  name           = "RootUsage"
  pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
  log_group_name = var.cloudtrail_loggroup

  metric_transformation {
    name      = "CloudTrailChanges"
    namespace = var.alarm_namespace
    value     = "1"
  }

  depends_on = [
    module.log_group
  ]
}

resource "aws_cloudwatch_metric_alarm" "root_usage_alarm" {
  alarm_name                = "RootUsage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.root_usage_alarm.id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "3"
  alarm_description         = "Monitoring for root account logins will provide visibility into the use of a fully privileged account and an opportunity to reduce the use of it."
  alarm_actions             = [aws_sns_topic.topic.arn]
  ok_actions                = [aws_sns_topic.topic.arn]
  treat_missing_data        = "missing"
  insufficient_data_actions = []
}
