
#############################################global variables####################################################

variable "aws_region" { default = ""}  //change region 
variable "sns_subscriber_email" { default = "abc@companyx.com"} // email endpoint for SNS notifications. For organizations, this should preferable be a distribution group.
variable "company_name" { default = "companyname"}   //add the company name/alias
variable "environment" { default = "environment" } //add the environment e.g. prod, uat,dev

#############################################S3 log buckets lifecycle buckets #############################################

variable "guard_duty_lifecycle_bucket" {default = "90"}
variable "config_lifecycle_bucket" {default = "90"}
variable "cloudtrail_lifecycle_bucket" {default = "90"}
variable "terraform_lifecycle_bucket" {default = "90"}
variable "vpc_flow_logs_lifecycle_bucket" {default = "90"}
variable "cloudfront_logs_lifecycle_bucket" {default = "90"}
variable "elb_logs_lifecycle_bucket" {default = "90"}
variable "waf_logs_lifecycle_bucket" {default = "90"}

#############################################Service Varibles#############################################

variable "kms_key_deletion_window" {default = "7"}
variable "config_name" { default = "${company_name}-${environment}-config"}

