variable "shard_id" {
  description = "Text used to identify shard of infrastructure components. For new shards, this should be only the shard id and should not include the AWS region (e.g. ap01)"
}

variable "private_subnets" {
  description = "A comma-delimited list of private subnets for the VPC"
  type        = list(string)
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

variable "os_type" {
  description = "os type of codebuild container"
  default     = "LINUX_CONTAINER"
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

variable "build_timeout" {
  default = "30"
}

variable "environment_variables" {
  type = list(object({
    env_name = string
    env_value = string
  }))
  
}