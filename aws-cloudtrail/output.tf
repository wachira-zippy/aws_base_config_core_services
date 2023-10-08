output "cloudtrail_id" {
  value = aws_cloudtrail.aws_cloudtrail.*.id
}

output "cloudtrail_arn" {
  value = aws_cloudtrail.aws_cloudtrail.*.arn
}

output "cloudtrail_home_region" {
  value = aws_cloudtrail.aws_cloudtrail.*.home_region
}