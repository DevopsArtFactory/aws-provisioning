variable "service_name" {}

variable "domain_name" {}

variable "web_acl_id" {}

variable "shard_id" {}

variable "target_vpc" {}

variable "private_subnets" {}

variable "deployment_default_sg" {}

variable "account_id" {}

variable "acm_external_ssl_certificate_arn" {
  description = "ssl cert id"
  default     = ""
}

variable "route53_external_zone_id" {
  description = "r53 zone id"
  default     = ""
}

variable "cnames" {}

variable "s3_cors_rules" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    max_age_seconds = number
  }))
  default = null
}
