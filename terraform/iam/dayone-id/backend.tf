terraform {
  required_version = "= 0.12.18" # Terraform Version 

  backend "s3" {
    bucket         = "dayone-id-apnortheast2-tfstate" # Set bucket name 
    key            = "dayone/terraform/iam/dayone-id/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock" # Set DynamoDB Table
  }
}
