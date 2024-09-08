terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    bucket         = "devart-preprod-apnortheast2-tfstate"
    key            = "devart/terraform/securitygroup/devart-id/eksd_apnortheast2/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

