terraform {
  required_version = "= 0.12.29"

  backend "s3" {
    bucket         = "art-id-apnortheast2-tfstate"
    key            = "art/terraform/kms/art-id/id_apsoutheast1/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
