//budget variables

variable "budget_name" { default = "${company_name}-${environment}_budget_report" }
variable "subscriber_email_addresses" { default = [""] }
variable "escalations_email_addresses" { default = [""] }
variable "monitor_email_addresses" { default = [""] }
variable "budget_type" { default = "COST" }
variable "limit_amount" { default = "xxx" }
variable "limit_unit" { default = "USD" }
variable "time_unit" { default = "MONTHLY" }
variable "include_credit" { default = false }
variable "include_refund" { default = false }
variable "include_discount" { default = false }
variable "use_amortized" { default = false }
variable "include_other_subscription" { default = true }
variable "include_recurring" { default = true }
variable "include_subscription" { default = true }
variable "include_support" { default = true }
variable "include_tax" { default = true }
variable "include_upfront" { default = true }
variable "use_blended" { default = true }
