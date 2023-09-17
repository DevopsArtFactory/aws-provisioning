variable "vpc_name" {
  description = "The name of the VPC"
}

variable "cidr_numeral" {
  description = "The VPC CIDR numeral (10.x.0.0/16)"
}

variable "aws_region" {
  default = "ap-northeast-2"
}

variable "shard_id" {
  default = ""
}

variable "shard_short_id" {
  default = ""
}

variable "cidr_numeral_public" {
  default = {
    "0" = "0"
    "1" = "16"
    "2" = "32"
  }
}

variable "cidr_numeral_private" {
  default = {
    "0" = "80"
    "1" = "96"
    "2" = "112"
  }
}

variable "cidr_numeral_private_db" {
  default = {
    "0" = "160"
    "1" = "176"
    "2" = "192"
  }
}

variable "billing_tag" {
  description = "The AWS tag used to track AWS charges."
}

variable "availability_zones" {
  type        = list(string)
  description = "A comma-delimited list of availability zones for the VPC."
}


variable "availability_zones_without_b" {
  type        = list(string)
  description = "A comma-delimited list of availability zones except for ap-northeast-2b"
}

variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}

variable "atlantis_user" {
  description = "The username that will be triggering atlantis commands. This will be used to name the session when assuming a role. More information - https://github.com/runatlantis/atlantis#assume-role-session-names"
  default     = "atlantis_user"
}

variable "subnet_no_private" {
  description = "This value means the number of private subnets"
  default     = "3"
}

variable "env_suffix" {
  description = "env suffix"
  default     = ""
}
