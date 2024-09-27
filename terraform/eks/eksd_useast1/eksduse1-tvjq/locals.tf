locals {
  # Account Information
  account_id = var.account_id[var.account_alias]

  # Cluster Information
  cluster_name           = data.terraform_remote_state.vpc.outputs.eks_cluster_name
  cluster_version        = var.cluster_version
  service_ipv4_cidr      = var.service_ipv4_cidr
  release_version        = var.release_version
  coredns_version        = var.coredns_version
  kube_proxy_version     = var.kube_proxy_version
  vpc_cni_version        = var.vpc_cni_version
  ebs_csi_driver_version = var.ebs_csi_driver_version
  pod_identity_agent_version = var.pod_identity_agent_version
  public_subnets         = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets        = data.terraform_remote_state.vpc.outputs.private_subnets
  cluster_subnet_ids     = data.terraform_remote_state.vpc.outputs.private_subnets
  target_vpc             = data.terraform_remote_state.vpc.outputs.vpc_id
  enable_public_access   = var.enable_public_access
  # additional security group
  additional_security_group_ingress = var.additional_security_group_ingress

  # Fargate on EKS feature
  fargate_enabled      = var.fargate_enabled
  fargate_profile_name = var.fargate_enabled ? var.fargate_profile_name ? var.fargate_profile_name : "" : ""

  # IRSA Local Variables
  external_secrets_access_kms_arns            = var.external_secrets_access_kms_arns
  external_secrets_access_ssm_arns            = var.external_secrets_access_ssm_arns
  external_secrets_access_secretsmanager_arns = var.external_secrets_access_secretsmanager_arns

  # Cluster service role
  cluster_policy_list = var.cluster_policy_list

  # Cluster Access Roles
  # Please do not add the default roles or users here.
  aws_auth_master_users_arn = length(var.aws_auth_master_users_arn) > 0 ? var.aws_auth_master_users_arn : []
  aws_auth_master_roles_arn = length(var.aws_auth_master_roles_arn) > 0 ? var.aws_auth_master_roles_arn : []
  aws_auth_viewer_users_arn = length(var.aws_auth_viewer_users_arn) > 0 ? var.aws_auth_viewer_users_arn : []
  aws_auth_viewer_roles_arn = length(var.aws_auth_viewer_roles_arn) > 0 ? var.aws_auth_viewer_roles_arn : []

  role_args                 = length(var.assume_role_arn) > 0 ? ["--role-arn", var.assume_role_arn] : []
  assume_role_arn           = length(var.assume_role_arn) > 0 ? var.assume_role_arn : ""
  node_group_configurations = var.node_group_configurations != null && length(var.node_group_configurations) > 0 ? var.node_group_configurations : []

  common_tags = (tomap({
    "product"    = var.product,
    "account"    = var.account_alias,
    "shard_id"   = data.terraform_remote_state.vpc.outputs.shard_id
    "aws_region" = data.terraform_remote_state.vpc.outputs.aws_region
  }))

  tags = merge(var.tags, local.common_tags)

  # CoreDNS Addon Configuration Values
  configuration_values = jsonencode({
    "nodeSelector" : {
      "capacity_type" : "cpu_on_demand"
    },
  })

  # VPC CNI Addon Configuration Values
  vpc_cni_configuration_values = jsonencode({
    "enableNetworkPolicy" : "true"
  })
}
