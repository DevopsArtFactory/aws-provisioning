variable "name" {
  type        = string
  description = "name"
}

variable "allowed_arns_for_common" {
  type        = list(string)
  description = "Assuming is allowed for AWS ARNs"
  validation {
    condition     = alltrue([for id in var.allowed_arns_for_common : can(regex("^arn:aws:iam::[0-9]{12}", id))])
    error_message = "The values must be AWS IAM ARN"
  }
}

variable "allowed_arns_for_secure" {
  type        = list(string)
  description = "Assuming is allowed for AWS ARNs"
  validation {
    condition     = alltrue([for id in var.allowed_arns_for_secure : can(regex("^arn:aws:iam::[0-9]{12}", id))])
    error_message = "The values must be AWS IAM ARN"
  }
}
