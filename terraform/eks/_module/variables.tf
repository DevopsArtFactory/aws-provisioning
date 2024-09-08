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

variable "release_version" {
  description = "eks ami release version"
}

variable "private_subnets" {
  description = "A comma-delimited list of private subnets for the VPC"
  type        = list(any)
}

variable "public_subnets" {
  description = "A comma-delimited list of public subnets for the VPC"
  type        = list(any)
}

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "subnet ids that will be used for the kubernetes cluster"
  default     = []
}

variable "enable_public_access" {
  type        = bool
  description = "whether or not public access to eks cluster"
  default     = false
}

variable "target_vpc" {
  description = "The AWS ID of the VPC this shard is being deployed into"
}

variable "node_group_configurations" {
  type = list(object({
    name                = string
    spot_enabled        = bool
    disk_size           = number
    ami_type            = string
    labels              = map(string)
    release_version     = optional(string)
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

variable "auth_additional_roles_arn" {
  description = "additional IAM role accessing cluster"
  type = list(object({
    role_arn = string
    username = string
    groups   = list(string)
  }))
  default = []
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

variable "pod_identity_agent_version" {
  default = ""
}

variable "deploy_pod_identity_agent" {
  description = "Set to true if you want to deploy the pod identity agent addon"
  type        = bool
  default     = false
}

variable "coredns_version" {
  default = ""
}

variable "ebs_csi_driver_version" {
  default = ""
}

variable "kube_proxy_version" {
  default = ""
}

variable "vpc_cni_version" {
  default = ""
}

variable "service_ipv4_cidr" {
  default = ""
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "cidr list from public access"
  default     = ["0.0.0.0/0"]
}

variable "configuration_values" {
  description = "custom configuration values for addons with single JSON string"
  default     = ""
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
  description = "additional security group ingress rule"
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
