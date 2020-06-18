terraform {
  required_version = "= 0.12.18"

  backend "s3" {
    bucket         = "art-id-apnortheast2-tfstate"
    key            = "art/terraform/services/hello/artd_apnortheast2/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
