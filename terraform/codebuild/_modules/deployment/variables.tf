
variable "shard_id" {
  description = "Text used to identify shard of infrastructure components. For new shards, this should be only the shard id and should not include the AWS region (e.g. ap01)"
}

variable "env_suffix" {
  description = "It's used for latency dns"
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

variable "billing_tag" {
  description = "The shard's default billing tag"
}

variable "target_vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}

variable "vpc_name" {
  description = "The unique VPC name this storage layer belongs to"
}

variable "route53_external_zone_id" {
  description = "r53 zone id"
  default     = ""
}

variable "vpc_cidr_numeral" {
  description = "The VPC CIDR numeral (e.g. 'n' in 10.n.0.0/16)"
}

variable "acm_external_ssl_certificate_arn" {
  description = "ssl cert id"
  default     = ""
}

variable "home_sg" {
  description = "people IP list."
  default     = ""
}

variable "deployment_arn" {
  description = "aws iam role deployment arn."
  default     = ""
}

variable "art_deployment_bucket" {
  description = "aws s3 bucket deployment arn."
  default     = ""
}

variable "compute_type" {
  description = "compute type for build container."
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "Container image for codebuild."
  default     = "aws/codebuild/standard:1.0"
}

variable "service_name" {
  description = "service name"
}

variable "service_role" {
  description = "IAM role for deployment build."
}

variable "github_repo" {
  description = "github repo in codebuild"
}

variable "buildspec" {
  description = "buildspec file name"
  default     = "buildspec.yml"
}

variable "privileged_mode" {
  description = "buildspec file name"
  default     = false
}

variable "image_credentials_type" {
  description = "image_pull_credentials_type"
  default     = "CODEBUILD"
}

variable "cache_type" {
  description = "Cache type"
  default     = "NO_CACHE"
}

variable "deployment_default_sg" {
  description = "default security group"
}

