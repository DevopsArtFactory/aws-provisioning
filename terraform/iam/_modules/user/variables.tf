/*
 * Required
 */

variable "company_email" {
  description = "The email that will be used in the AWS account"
}

variable "force_destroy" {
  description = "Enable to destroy the iam user"
  default     = false
}

variable "role" {
  description = "User Role on Company (Member, Intern)"
}
