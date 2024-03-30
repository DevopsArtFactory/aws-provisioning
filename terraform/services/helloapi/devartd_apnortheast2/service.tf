# Use module for service
module "helloapi" {
  source = "../_module/helloapi"

  # Name of service
  service_name = "helloapi"

  # Port for service and healthcheck
  service_port     = 80
  healthcheck_port = 80

  # VPC Information via remote_state
  shard_id                 = data.terraform_remote_state.vpc.outputs.shard_id
  public_subnets           = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
  aws_region               = data.terraform_remote_state.vpc.outputs.aws_region
  vpc_cidr_numeral         = data.terraform_remote_state.vpc.outputs.cidr_numeral
  route53_internal_domain  = data.terraform_remote_state.vpc.outputs.route53_internal_domain
  route53_internal_zone_id = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
  target_vpc               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name                 = data.terraform_remote_state.vpc.outputs.vpc_name
  billing_tag              = data.terraform_remote_state.vpc.outputs.billing_tag

  # Domain Name 
  # This will be the prefix of record 
  # e.g) helloapi.devops-art-factory.com
  domain_name = "helloapi-dev"

  # Route53 variables
  acm_external_ssl_certificate_arn = var.r53_variables.id.star_devart_tv_acm_arn_apnortheast2
  route53_external_zone_id         = var.r53_variables.id.devart_tv_zone_id

  # Resource LoadBalancer variables
  lb_variables = var.lb_variables

  # Security Group variables
  sg_variables = var.sg_variables

  # Home Security Group via remote_state
  home_sg = data.terraform_remote_state.vpc.outputs.aws_security_group_home_id

  # CIDR for external LB
  # Control allowed IP for external LB 
  ext_lb_ingress_cidrs = [
    "0.0.0.0/0"
  ]

}
