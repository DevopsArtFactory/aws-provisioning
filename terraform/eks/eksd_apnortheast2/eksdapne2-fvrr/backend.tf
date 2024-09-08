terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    bucket         = "devart-preprod-apnortheast2-tfstate"
    key            = "devart/terraform/eks/eksd_apnortheast2/eksdapne2-fvrr/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

