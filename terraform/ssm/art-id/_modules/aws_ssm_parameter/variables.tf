variable "ssm_parameter_name" {
  description = "Name of parameter"
}

variable "ssm_parameter_type" {
  description = "Type of parameter"
  default     = "SecureString"
}

variable "ssm_parameter_key_id" {
  description = "KMS Key id of parameter"
  default     = ""
}

variable "ssm_parameter_value" {
  description = "Value of parameter"
}
