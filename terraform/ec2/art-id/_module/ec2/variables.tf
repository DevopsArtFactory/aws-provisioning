variable "service_name" {}

variable "base_ami" {}

variable "instance_profile" {}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_name" {}

variable "private_subnets" {}

variable "public_subnets" {}

variable "target_vpc" {}

variable "shard_id" {}

variable "stack" {}

variable "key_name" {}

variable "acm_external_ssl_certificate_arn" {
  default = ""
}

variable "ext_lb_ingress_cidrs" {}
variable "route53_internal_zone_id" {

}

variable "route53_external_zone_id" {
  default = ""
}

variable "route53_internal_domain" {
  default = ""
}

variable "ebs_optimized" {}

variable "internal_domain_name" {}
