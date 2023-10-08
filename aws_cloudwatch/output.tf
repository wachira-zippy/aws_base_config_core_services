output "cloudwatch_log_group_name" {
  value = element(concat(aws_cloudwatch_log_group.loggroup.*.name, [""]), 0)
}

output "cloudwatch_log_group_arn" {
  value = element(concat(aws_cloudwatch_log_group.loggroup.*.arn, [""]), 0)
}