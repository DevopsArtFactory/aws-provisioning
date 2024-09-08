variable "shard_id" {
  description = "Text used to identify shard of infrastructure components. For new shards, this should be only the shard id and should not include the AWS region (e.g. ap01)"
}

variable "private_subnets" {
  description = "A comma-delimited list of private subnets for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "A comma-delimited list of public subnets for the VPC"
  type        = list(string)
}

variable "aws_region" {
  description = "The AWS region to deploy the shard storage layer into"
}

variable "target_vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}

variable "vpc_name" {
  description = "The unique VPC name this storage layer belongs to"
}

variable "route53_external_zone_id" {
  description = "r53 zone id"
}

variable "ssl_certificate_id" {
  description = "ssl cert id"
}

variable "deployment_common_arn" {
  description = "The ARN of KMS for deployment_common."
}

variable "efs_throughput_mode" {
  default = "bursting"
}

variable "efs_provisioned_throughput_in_mibps" {
  default = ""
}

variable "ingress_cidr_blocks" {}

variable "egress_cidr_blocks" {}

variable "project_tags" {}

variable "service_name" {}

variable "enable_internal" {
  default = false
}

variable "enable_external" {
  default = true
}