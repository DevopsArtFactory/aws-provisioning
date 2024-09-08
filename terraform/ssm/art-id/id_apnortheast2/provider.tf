provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}

provider "sops" {
}

terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.0.0"
    }
  }
}
