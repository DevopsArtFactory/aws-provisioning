variable "service_name" {
  description = "name of service"
}

variable "shard_id" {
  description = "Text used to identify shard of infrastructure components. For new shards, this should be only the shard id and should not include the AWS region (e.g. ap01)"
}

variable "target_vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}

variable "vpc_name" {
  description = "The unique VPC name this storage layer belongs to"
}

variable "ext_lb_accesslog_bucket" {
  description = "The name of s3 bucket for elb accesslog"
  default     = ""
}

variable "ext_lb_ingress_cidrs" {
  default = [
  ]
}

