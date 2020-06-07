terraform {
  required_version = "= 0.12.18"

  backend "s3" {
    bucket         = "dayone-id-apnortheast2-tfstate"
    key            = "dayone/terroform/platform/atlantis/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
