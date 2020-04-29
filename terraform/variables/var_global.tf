# Atlantis user
variable "atlantis_user" {
  description = "The username that will be triggering atlantis commands. This will be used to name the session when assuming a role. More information - https://github.com/runatlantis/atlantis#assume-role-session-names"
  default     = "atlantis_user"
}

# Account IDs
# Add all account ID to here 
variable "account_id" {
  default = {
    prod     = "229438263680"
  }
}

# Remote State that will be used when creating other resources
# You can add any resource here, if you want to refer from others
variable "remote_state" {
  default = {
    # VPC
    vpc = {
      dayonedapne2 = {
        region = "ap-northeast-2"
        bucket = "dayone-prod-apnortheast2-tfstate"
        key    = "dayone/terraform/vpc/dayoned_apnortheast2/terraform.tfstate"
      }

      dayonepapne2 = {
        region = "ap-northeast-2"
        bucket = "dayone-prod-apnortheast2-tfstate"
        key    = "dayone/terraform/vpc/dayonep_apnortheast2/terraform.tfstate"
      }
    }


    # WAF ACL
    waf_web_acl_global = {
      prod = {
        region = ""
        bucket = ""
        key    = ""
      }
    }


    # AWS IAM
    iam = {
      prod = {
        region = "ap-northeast-2"
        bucket = "dayone-prod-apnortheast2-tfstate"
        key    = "dayone/terraform/iam/dayone-prod/terraform.tfstate"
      }
    }


    # AWS KMS
    kms = {
      prod = {
        apne2 = {
          region = "ap-northeast-2"
          bucket = "dayone-prod-apnortheast2-tfstate"
          key    = "dayone/terraform/kms/dayone-prod/prod_apnortheast2/terraform.tfstate"
        }
      }
    }
  }
}
