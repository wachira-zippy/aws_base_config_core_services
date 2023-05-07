variable "aws_region" {
  default = "eu-west-1"
}

variable "client_name" {
  default = "silicon"
}

variable "terraform_state" {
  default = "terraform-state"
}

variable "sns_subscriber_email" {
  default = "charlton@overdrive.co.za"
}

variable "config_name" {
  default = "silicon-overdrive-staging-config"
}

variable "config_bucket" {
  default = "silicon-overdrive-staging-config-log"
}

variable "cloudtrail_bucket" {
  default = "silicon-overdrive-staging-cloudtrail-log"
}

variable "cloudtrail_loggroup" {
  default = "silicon-overdrive-staging-cloudtrail-log"
}

variable "guard_duty_bucket" {
  default = "silicon-overdrive-staging-guard-duty-logs"
}
