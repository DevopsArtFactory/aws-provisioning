provider "aws" {
  region  = "ap-northeast-2"

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}
