provider "aws" {
  region  = "ap-northeast-2" # Please use the default region ID
  version = "~> 2.49.0"      # Please choose any version or delete this line if you want the latest version

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.account_id}-apnortheast2-tfstate"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

variable "account_id" {
  default = "dayone-test-test" # Please use the account alias for id
}



variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}

variable "atlantis_user" {
  description = "The username that will be triggering atlantis commands. This will be used to name the session when assuming a role. More information - https://github.com/runatlantis/atlantis#assume-role-session-names"
  default     = "atlantis_user"
}

