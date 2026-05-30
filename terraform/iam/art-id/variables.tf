variable "aws_region" {
  description = "The AWS region to deploy the shard storage layer into"
}

variable "remote_state_region" {
  default = "ap-northeast-2"
}

variable "remote_state_bucket" {
  default = ""
}


variable "prod_account_id" {
  description = "The AWS account number for produdction"
}

variable "remote_state_key_map" {
  type = map(string)

  default = {
    "kms_apne2" = "art/terraform/kms/art-id/id_apnortheast2/terraform.tfstate"
  }
}

variable "teamjupiter_aws_region" {
  description = "AWS region for Team Jupiter download request resources."
  default     = "ap-northeast-2"
}

variable "teamjupiter_vercel_team_slug" {
  description = "Vercel team slug used as the OIDC issuer namespace."
  default     = "companyjupiter"
}

variable "teamjupiter_vercel_project_names" {
  description = "Allowed Vercel project names that can assume the Team Jupiter download role."
  type        = list(string)
  default = [
    "teamjupiter.ai",
    "teamjupiter-ai"
  ]
}

variable "teamjupiter_vercel_environments" {
  description = "Allowed Vercel deployment environments that can assume the Team Jupiter download role."
  type        = list(string)
  default     = ["production"]
}

variable "teamjupiter_vercel_oidc_thumbprint_list" {
  description = "Thumbprints for the Vercel OIDC provider. AWS validates trusted-root OIDC providers through its CA bundle; this placeholder satisfies older Terraform provider schemas."
  type        = list(string)
  default     = ["ffffffffffffffffffffffffffffffffffffffff"]
}

variable "teamjupiter_download_requests_table_name" {
  description = "DynamoDB table name for Team Jupiter download access request submissions."
  default     = "teamjupiter_download_requests"
}

variable "teamjupiter_downloads_bucket_name" {
  description = "S3 bucket name for private Team Jupiter downloadable artifacts."
  default     = "devart-teamjupiter-downloads-artdapne2"
}

variable "teamjupiter_download_object_prefixes" {
  description = "S3 object prefixes that Vercel may presign for Team Jupiter downloads."
  type        = list(string)
  default = [
    "sovereign/",
    "neuronfs/"
  ]
}
