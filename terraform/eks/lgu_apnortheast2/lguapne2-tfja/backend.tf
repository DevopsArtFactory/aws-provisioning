terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "art-id-apnortheast2-tfstate"
    key            = "art/terraform/eks/lgu_apnortheast2/lguapne2-tfja/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
