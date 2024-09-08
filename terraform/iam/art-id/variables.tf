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
