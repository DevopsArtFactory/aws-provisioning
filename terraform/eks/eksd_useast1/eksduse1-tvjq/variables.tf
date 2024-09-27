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

variable "service_ipv4_cidr" {
  type        = string
  description = "kubernetes service ipv4 cidr"
  default     = "172.30.0.0/16"
}

variable "release_version" {
  type        = string
  description = "Version of EKS AMI"
}

variable "coredns_version" {
  type        = string
  description = "Version of coredns addon"
}

variable "kube_proxy_version" {
  type        = string
  description = "Version of kube-proxy addon"
}

variable "pod_identity_agent_version" {
  type        = string
  description = "Version of pod identity agent addon"
}

variable "vpc_cni_version" {
  type        = string
  description = "version of vpc_cni"
}

variable "ebs_csi_driver_version" {
  type        = string
  description = "version of ebs_csi_driver_version"
}

variable "enable_public_access" {
  type        = bool
  description = "Whether or not to Access Kubernetes From Public"
  default     = false
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
    release_version     = optional(string)
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

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "subnet ids that will be used for the kubernetes cluster"
  default     = []
}

variable "cluster_policy_list" {
  type = list(object({
    type       = string
    identifier = list(string)
  }))
  description = "eks cluster iam assume role policy statement list"
  default     = []
}

variable "additional_security_group_ingress" {
  description = "additional ingress rule"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default = []
}

variable "vpc_cni_configuration_values" {
  description = "custom configuration values for vpc_cni addons with single JSON string"
  default     = ""
}

variable "external_secrets_access_kms_arns" {
  type        = list(string)
  description = "ARNs for external access to KMS"
  default     = ["*"]
}

variable "external_secrets_access_ssm_arns" {
  type        = list(string)
  description = "ARNs for external access to SSM"
  default     = ["*"]
}

variable "external_secrets_access_secretsmanager_arns" {
  type        = list(string)
  description = "ARNs for external access to SecretsManager"
  default     = ["*"]
}
