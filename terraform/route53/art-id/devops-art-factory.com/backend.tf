terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket         = "art-id-apnortheast2-tfstate"
    key            = "aws-provisioning/terraform/route53/art-id/devops-art-factory.com/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

