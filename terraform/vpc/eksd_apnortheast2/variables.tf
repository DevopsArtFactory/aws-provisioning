variable "product" {
  description = "The name of the VPC"
}

variable "cidr_numeral" {
  description = "The VPC CIDR numeral (10.x.0.0/16)"
}

variable "aws_short_region" {
  default = "apne2"
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
    "3" = "48"
  }
  #    "4" = "64"
}

variable "cidr_numeral_private" {
  default = {
    "0" = "80"
    "1" = "96"
    "2" = "112"
    "3" = "128"
  }
  #    "4" = "144"
}

variable "cidr_numeral_private_db" {
  default = {
    "0" = "160"
    "1" = "176"
    "2" = "192"
    "3" = "208"
  }
  #    "4" = "224"
}

variable "billing_tag" {
  description = "The AWS tag used to track AWS charges."
}

variable "availability_zones" {
  type        = list(string)
  description = "A comma-delimited list of availability zones for the VPC."
}

variable "internal_domain" {
  description = "regional internal domain name"
  default     = "devart.internal"
}

variable "env_suffix" {
  description = "env suffix"
  default     = ""
}

variable "peering_requests" {
  type = list(object({
    id         = string
    vpc_name   = string
    cidr_block = string
  }))
  description = "A list of peering requests for private subnets"
}

variable "db_peering_requests" {
  type = list(object({
    id         = string
    vpc_name   = string
    cidr_block = string
  }))
  description = "A list of peering requests for private db subnets"
}