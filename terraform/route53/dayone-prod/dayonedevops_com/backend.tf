terraform {
  required_version = "0.12.18"

  backend "s3" {
    bucket         = "dayone-prod-apnortheast2-tfstate"
    key            = "dayone/terraform/route53/dayone-prod/dayonedevops_com/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

