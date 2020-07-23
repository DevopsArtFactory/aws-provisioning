terraform {
  required_version = "= 0.12.24"

  backend "s3" {
    bucket         = "art-prod-apnortheast2-tfstate"
    key            = "art/terraform/codebuild/artp_apnortheast2/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

