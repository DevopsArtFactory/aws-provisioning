provider "aws" {
  region  = "us-east-1"
  version = "~> 2.49.0"

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}

