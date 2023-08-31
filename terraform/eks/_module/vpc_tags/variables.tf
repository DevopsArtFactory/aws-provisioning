variable "cluster_name" {
  description = "name of cluster"
}

variable "private_subnets" {
  description = "A comma-delimited list of private subnets for the VPC"
  type        = list(any)
}

variable "public_subnets" {
  description = "A comma-delimited list of public subnets for the VPC"
  type        = list(any)
}

variable "target_vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}
