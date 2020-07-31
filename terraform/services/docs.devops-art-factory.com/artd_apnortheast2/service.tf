module "docs_devops_art_factory_com" {
  source = "../_module/docs_devops_art_factory_com"
  service_name                  = var.service_name

  # Remote State
  shard_id                      = data.terraform_remote_state.vpc.outputs.shard_id
  private_subnets               = data.terraform_remote_state.vpc.outputs.private_subnets
  target_vpc                    = data.terraform_remote_state.vpc.outputs.vpc_id
  deployment_default_sg         = data.terraform_remote_state.vpc.outputs.aws_security_group_default_id

  # Vars
  account_id =  var.account_id.id

  # Route53 variables
  acm_external_ssl_certificate_arn  = var.r53_variables.id.star_devopsartfactory_com_acm_arn_useast1
  route53_external_zone_id          = var.r53_variables.id.devopsartfactory_com_zone_id

  # Specific variables
  domain_name                   = "docs.devops-art-factory.com"
  cnames                        = ["docs.devops-art-factory.com"]

  web_acl_id                    = ""

  s3_cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET"]
      allowed_origins = ["https://stage-data.kiswe.com", "https://data.kiswe.com"]
      max_age_seconds = 3000
    }
  ]
}
