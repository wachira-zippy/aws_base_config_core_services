variable "contact_type_security" { default = "SECURITY" }
variable "name_security" { default = "Charlton Daniels" }
variable "title_security" { default = "Solutions Architect" }
variable "email_address_security" { default = "charlton@overdrive.co.za" }
variable "phone_number_security" { default = "+27769197083" }

variable "contact_type_operations" { default = "OPERATIONS" }
variable "name_operations" { default = "Charlton Daniels" }
variable "title_operations" { default = "Solutions Architect" }
variable "email_address_operations" { default = "charlton@overdrive.co.za" }
variable "phone_number_operations" { default = "+27769197083" }

variable "contact_type_billing" { default = "BILLING" }
variable "name_billing" { default = "Charlton Daniels" }
variable "title_billing" { default = "Solutions Architect" }
variable "email_address_billing" { default = "charlton@overdrive.co.za" }
variable "phone_number_billing" { default = "+27769197083" }

variable "budget_name" { default = "silicon_overdrive_staging_budget_report" }
variable "subscriber_email_addresses" { default = ["charlton@overdrive.co.za"] }
variable "escalations_email_addresses" { default = ["charlton@overdrive.co.za", "awsbudgetalerts@overdrive.co.za", "aws.escalations@overdrive.co.za"] }
variable "monitor_email_addresses" { default = ["charlton@overdrive.co.za", "awsbudgetalerts@overdrive.co.za"] }
variable "budget_type" { default = "COST" }
variable "limit_amount" { default = "100" }
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
