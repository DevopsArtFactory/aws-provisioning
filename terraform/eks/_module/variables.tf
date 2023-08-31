variable "aws_region" {
  default = "ap-northeast-2"
}

variable "account_id" {
  description = "aws account id"
}

variable "cluster_name" {
  description = "name of cluster"
}

variable "cluster_version" {
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

variable "node_group_configurations" {
  type = list(object({
    name                = string
    spot_enabled        = bool
    release_version     = optional(string)
    disk_size           = number
    ami_type            = string
    labels              = map(string)
    node_instance_types = list(string)
    node_min_size       = number
    node_desired_size   = number
    node_max_size       = number
  }))

  description = "Overall node group configurations"
}

variable "node_max_unavailable" {
  description = "max unavailable node size"
  default     = 1
}

variable "aws_auth_master_roles_arn" {
  description = "master IAM role accessing cluster"
  default     = []
}

variable "aws_auth_master_users_arn" {
  description = "master IAM user accessing cluster"
  default     = []
}

variable "aws_auth_viewer_roles_arn" {
  description = "viewer IAM role accessing cluster"
  default     = []
}

variable "aws_auth_viewer_users_arn" {
  description = "viewer IAM user accessing cluster"
  default     = []
}

variable "assume_role_arn" {
  description = "role arn"
  default     = ""
}

variable "fargate_enable" {
  description = "Determines whether to create Fargate profile or not"
  type        = bool
  default     = false
}

variable "fargate_profile_name" {
  description = "fargate profile name"
}


variable "selectors" {
  description = "Configuration block(s) for selecting Kubernetes Pods to execute with this Fargate Profile"
  type        = any
  default     = []
}

variable "timeouts" {
  description = "Create and delete timeout configurations for the Fargate Profile"
  type        = map(string)
  default     = {}
}

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "coredns_version" {
  description = "version of coredns"
}

variable "kube_proxy_version" {
  description = "version of kube_proxy"
}

variable "vpc_cni_version" {
  description = "version of vpc_cni"
}

variable "aws_ebs_csi_driver_version" {
  description = "version of aws_ebs_csi_driver"
}

variable "node_group_release_version" {
  description = "version of Managed Node Group"
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "cidr list from public access"
  default     = ["0.0.0.0/0"]
}

variable "enable_public_access" {
  type        = bool
  description = "whether or not public access to eks cluster"
  default     = true
}

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "subnet ids that will be used for the kubernetes cluster"
}

variable "configuration_values" {
  description = "custom configuration values for addons with single JSON string"
  default     = ""
}

variable "additional_ingress" {
  description = "additional ingress rule"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "cluster_policy_list" {
  type = list(object({
    type       = string
    identifier = list(string)
  }))
  description = "eks cluster iam assume role policy statement list"
  default     = []
}