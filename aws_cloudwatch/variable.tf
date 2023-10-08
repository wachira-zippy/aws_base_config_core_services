variable "create" {
  type    = bool
  default = true
}

variable "name" {
  type    = string
  default = null
}

variable "name_prefix" {
  type    = string
  default = null
}

variable "retention_in_days" {
  type    = number
  default = null
}

variable "kms_key_id" {
  type    = string
  default = null
}
