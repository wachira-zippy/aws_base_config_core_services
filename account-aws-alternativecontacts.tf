resource "aws_account_alternate_contact" "operations" {

  alternate_contact_type = var.contact_type_operations

  name          = var.name_operations
  title         = var.title_operations
  email_address = var.email_address_operations
  phone_number  = var.phone_number_operations
}

resource "aws_account_alternate_contact" "security" {

  alternate_contact_type = var.contact_type_security

  name          = var.name_security
  title         = var.title_security
  email_address = var.email_address_security
  phone_number  = var.phone_number_security
}

resource "aws_account_alternate_contact" "billing" {

  alternate_contact_type = var.contact_type_billing

  name          = var.name_billing
  title         = var.title_billing
  email_address = var.email_address_billing
  phone_number  = var.phone_number_billing
}