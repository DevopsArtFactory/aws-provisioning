terraform {
  required_version = ">= 1.0.0" # Terraform Version

  backend "s3" {
    bucket         = "art-prod-apnortheast2-tfstate" # Set bucket name 
    key            = "art/terraform/iam/art-prod/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock" # Set DynamoDB Table
  }
}
