
terraform {
  required_version = "= 0.12.18"

  backend "s3" {
    bucket         = "dayone-prod-apnortheast2-tfstate"
    key            = "terraform/examples/atlantis/terraform/test/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
