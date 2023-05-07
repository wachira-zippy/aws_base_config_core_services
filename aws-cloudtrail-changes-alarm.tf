variable "alarm_namespace" {
  default = "cloudtrailloginalarmchanges"
}

variable "cloudtrail_log_group_name" {
  default = "cloudtraillogs"
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_changes" {
  name           = "CloudTrailChanges"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
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

resource "aws_cloudwatch_metric_alarm" "cloudtrail_changes" {
  alarm_name                = "CloudTrailChanges"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.cloudtrail_changes.id
  namespace                 = var.alarm_namespace
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring changes to CloudTrail's configuration will help ensure sustained visibility to activities performed in the AWS account."
  alarm_actions             = [aws_sns_topic.topic.arn]
  ok_actions                = [aws_sns_topic.topic.arn]
  treat_missing_data        = "missing"
  insufficient_data_actions = []

  depends_on = [
    module.log_group
  ]
}