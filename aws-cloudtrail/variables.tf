variable "name" {
  type      = string
  default   = ""
  sensitive = true
}

variable "s3_bucket_name" {
  type      = string
  default   = ""
  sensitive = true
}

variable "cloud_watch_logs_role_arn" {
  type      = string
  default   = ""
  sensitive = true
}

variable "cloud_watch_logs_group_arn" {
  type      = string
  default   = ""
  sensitive = true
}

variable "kms_key_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "enable_logging" {
  type    = bool
  default = true
}

variable "enable_log_file_validation" {
  type    = bool
  default = true
}

variable "is_multi_region_trail" {
  type    = bool
  default = true
}

variable "include_global_service_events" {
  type    = bool
  default = true
}

variable "s3_key_prefix" {
  type      = string
  default   = ""
  sensitive = true
}

