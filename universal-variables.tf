variable "aws_region" { //change region 
  default = ""
}

variable "sns_subscriber_email" { // email endpoint for SNS notifications. For organizations, this should preferable be a distribution group.
  default = "abc@companyx.com"
}

variable "config_name" {
  default = ""
}

//s3 logs bucket names for security services. Replace bucket names as per your standard naming convention. 

variable "config_bucket" { // needed
  default = "companyname-environment-bucketname" //e.g. abc-prod-config-logs-bucket
}

variable "cloudtrail_bucket" {
  default = "companyname-environment-bucketname"
}

variable "cloudtrail_loggroup" {
  default = "companyname-environment-cloudtrail-log"
}

variable "guard_duty_bucket" {
  default = "companyname-environment-bucketname"
}
