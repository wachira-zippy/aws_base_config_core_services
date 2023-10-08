// add names of all users who need to be created
variable "abc_admins" {  
  type    = list(string)
  default = ["x@abc.com", "y@abc.com",]
}

//variables for the account password policy
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
