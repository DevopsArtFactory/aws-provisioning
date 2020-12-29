variable "aws_region" {
  description = "The AWS region to deploy the shard storage layer into"
}

# Variables for Atlantis
variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}

