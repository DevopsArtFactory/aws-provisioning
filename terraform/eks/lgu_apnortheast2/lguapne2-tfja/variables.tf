variable "account_alias" {
  type        = string
  description = "Name of AWS account alias"
  default     = null

  validation {
    condition     = var.account_alias != null && length(var.account_alias) > 0
    error_message = "The account_alias variable is required."
  }
}

variable "product" {
  type        = string
  description = "Name of product"
  default     = null

  validation {
    condition     = var.product != null && length(var.product) > 0
    error_message = "The product variable is required."
  }
}

variable "cluster_version" {
  type        = string
  description = "Version of EKS cluster"
  default     = null

  validation {
    condition     = var.cluster_version != null && length(var.cluster_version) > 0
    error_message = "The cluster_version variable is required."
  }
}

variable "fargate_enabled" {
  type        = bool
  description = "Whether or not to use AWS Fargate on Kubernetes"
  default     = false
}

variable "fargate_profile_name" {
  type        = string
  description = "Name of profile that represents the AWS fargate. This variable nly works when fargate_enabled is true."
  default     = ""
}

variable "node_group_configurations" {
  type = list(object({
    name                = string
    spot_enabled        = bool
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

variable "aws_auth_master_roles_arn" {
  type        = list(string)
  description = "List of AWS IAM Role arns that will have a master role in the EKS cluster."
  default     = []
}

variable "aws_auth_master_users_arn" {
  type        = list(string)
  description = "List of AWS IAM User arns that will have a master role in the EKS cluster."
  default     = []
}

variable "aws_auth_viewer_roles_arn" {
  type        = list(string)
  description = "List of AWS IAM Role arns that will have a viewer role in the EKS cluster."
  default     = []
}

variable "aws_auth_viewer_users_arn" {
  type        = list(string)
  description = "List of AWS IAM User arns that will have a viewer role in the EKS cluster."
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
  description = "version of aws_ebs_csi_driver_version"
}

variable "node_group_release_version" {
  description = "version of Managed Node Group"
}

variable "enable_public_access" {
  type        = bool
  description = "whether or not public access to eks cluster"
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
