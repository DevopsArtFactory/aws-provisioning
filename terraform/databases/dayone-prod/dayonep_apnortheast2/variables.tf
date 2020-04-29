variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}

variable "dayone_aurora_endpoint" {
  description = "dayone aurora endpoint for write"
}

variable "dayone_aurora_reader_endpoint" {
  description = "dayone aurora reader endpoint for RO"
}
