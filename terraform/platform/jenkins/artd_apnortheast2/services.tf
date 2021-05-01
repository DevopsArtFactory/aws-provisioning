module "jenkins" {
  source           = "../_module/jenkins"
  service_name     = "jenkins"
  service_port     = 8080
  healthcheck_port = 8080
  account_id       = var.account_id.id

  shard_id                 = data.terraform_remote_state.vpc.outputs.shard_id
  public_subnets           = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
  aws_region               = data.terraform_remote_state.vpc.outputs.aws_region
  target_vpc               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name                 = data.terraform_remote_state.vpc.outputs.vpc_name
  vpc_cidr_numeral         = data.terraform_remote_state.vpc.outputs.cidr_numeral
  route53_internal_domain  = data.terraform_remote_state.vpc.outputs.route53_internal_domain
  route53_internal_zone_id = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
  billing_tag              = data.terraform_remote_state.vpc.outputs.billing_tag

  newrelic_monitor = "false"

  ssh_key_name = "art-id-master"

  instance_ami                        = var.jenkins_master_ami
  tag_first_owner                     = var.tag_first_owner
  tag_second_owner                    = var.tag_second_owner
  tag_project                         = var.tag_project
  efs_provisioned_throughput_in_mibps = 0

  #KMS Key for deployment
  deployment_common_arn = data.terraform_remote_state.kms.outputs.aws_kms_key_id_apne2_deployment_common_arn

  # Instance Count Variables
  instance_count_max     = 1
  instance_count_min     = 1
  instance_count_desired = 1

  # Route53 variables
  acm_external_ssl_certificate_arn = var.r53_variables.id.star_devopsartfactory_com_acm_arn_apnortheast2
  route53_external_zone_id         = var.r53_variables.id.devopsartfactory_com_zone_id
  domain_name                      = "jenkins"

  # Resource LoadBalancer variables
  lb_variables = var.lb_variables

  # Security Group variables
  sg_variables = var.sg_variables

  # Home Security Group via remote_state
  home_sg = data.terraform_remote_state.vpc.outputs.aws_security_group_home_id
  #github_hook_sg                = data.terraform_remote_state.vpc.outputs.aws_security_group_github_hook_id
  github_hook_sg = ""

  # CIDR for external LB
  # Control allowed IP for external LB 
  ext_lb_ingress_cidrs = [
    "0.0.0.0/0"
  ]
}

