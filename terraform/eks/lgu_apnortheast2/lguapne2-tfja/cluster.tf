module "eks" {
  source = "../../_module"

  account_id                 = local.account_id
  cluster_name               = local.cluster_name
  cluster_version            = local.cluster_version
  coredns_version            = local.coredns_version
  kube_proxy_version         = local.kube_proxy_version
  vpc_cni_version            = local.vpc_cni_version
  aws_ebs_csi_driver_version = local.aws_ebs_csi_driver_version
  node_group_release_version = local.node_group_release_version
  fargate_enable             = local.fargate_enabled
  fargate_profile_name       = local.fargate_profile_name
  public_subnets             = local.public_subnets
  private_subnets            = local.private_subnets
  target_vpc                 = local.target_vpc
  aws_auth_master_users_arn  = local.aws_auth_master_users_arn
  aws_auth_master_roles_arn  = local.aws_auth_master_roles_arn
  aws_auth_viewer_users_arn  = local.aws_auth_viewer_users_arn
  aws_auth_viewer_roles_arn  = local.aws_auth_viewer_roles_arn
  assume_role_arn            = local.assume_role_arn
  node_group_configurations  = local.node_group_configurations
  tags                       = local.tags
  enable_public_access       = local.enable_public_access
  cluster_subnet_ids         = local.public_subnets
  configuration_values       = local.configuration_values
  additional_ingress         = local.additional_ingress
}
