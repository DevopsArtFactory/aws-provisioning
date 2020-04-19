terraform {
  required_version = "= 0.12.18"

  backend "s3" {
    bucket         = "dayone-prod-apnortheast2-tfstate"
    key            = "dayone/terraform/s3/dayone-prod/prod_apnortheast2/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
