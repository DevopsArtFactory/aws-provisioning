/*
 * Required
 */

variable "team" {
  description = "team id"
}

variable "role" {
  description = "role id"
}

variable "subject" {
  description = ""
}

variable "resources" {
  type        = list(any)
  description = "List of affected resources."
  default     = ["*"]
}
