variable "silicon_names" {
  type    = list(string)
  default = ["charlton@overdrive.co.za", "chris@overdrive.co.za", "romano@overdrive.co.za"]
}

variable "client_names" {
  type    = list(string)
  default = ["jacques@overdrive.co.za", "mohamed@overdrive.co.za", "brian@overdrive.co.za", ]
}

variable "hard_expiry" {
  type    = string
  default = false
}

variable "require_numbers" {
  type    = bool
  default = true
}

variable "require_symbols" {
  type    = bool
  default = true
}

variable "max_password_age" {
  type    = number
  default = 90
}

variable "minimum_password_length" {
  type    = number
  default = 14
}

variable "password_reuse_prevention" {
  type    = number
  default = 24
}

variable "require_lowercase_characters" {
  type    = bool
  default = true
}

variable "require_uppercase_characters" {
  type    = bool
  default = true
}

variable "allow_users_to_change_password" {
  type    = bool
  default = true
}
