resource "aws_sns_topic" "topic" {
  name = "technical-alert"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = var.sns_subscriber_email
}
