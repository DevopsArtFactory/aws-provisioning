provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }

  ignore_tags {
    key_prefixes = ["kubernetes.io/", "karpenter.sh/"]
  }
}

provider "random" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
