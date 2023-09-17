terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-2"
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.account_id}-apnortheast2-tfstate"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

variable "account_id" {
  default = "devart-preprod" # Please use the account alias for id
}
