# Atlantis user
variable "atlantis_user" {
  description = "The username that will be triggering atlantis commands. This will be used to name the session when assuming a role. More information - https://github.com/runatlantis/atlantis#assume-role-session-names"
  default     = "atlantis_user"
}

# Account IDs
# Add all account ID to here 
variable "account_id" {
  default = {
    id   = "816736805842"
    prod = "002202845208"

  }
}

# Remote State that will be used when creating other resources
# You can add any resource here, if you want to refer from others
variable "remote_state" {
  default = {
    # VPC
    vpc = {
      artdapne2 = {
        region = "ap-northeast-2"
        bucket = "art-id-apnortheast2-tfstate"
        key    = "art/terraform/vpc/artd_apnortheast2/terraform.tfstate"
      }

      artpapne2 = {
        region = "ap-northeast-2"
        bucket = "art-prod-apnortheast2-tfstate"
        key    = "art/terraform/vpc/artp_apnortheast2/terraform.tfstate"
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

      id = {
        region = "ap-northeast-2"
        bucket = "art-id-apnortheast2-tfstate"
        key    = "art/terraform/iam/art-id/terraform.tfstate"
      }

      prod = {
        region = "ap-northeast-2"
        bucket = "art-id-apnortheast2-tfstate"
        key    = "art/terraform/iam/art-prod/terraform.tfstate"
      }
    }


    # AWS KMS
    kms = {

      id = {
        apne2 = {
          region = "ap-northeast-2"
          bucket = "art-id-apnortheast2-tfstate"
          key    = "art/terraform/kms/art-id/id_apnortheast2/terraform.tfstate"
        }
      }

      prod = {
        apne2 = {
          region = "ap-northeast-2"
          bucket = "art-prod-apnortheast2-tfstate"
          key    = "art/terraform/kms/art-prod/prod_apnortheast2/terraform.tfstate"
        }
      }


    }
  }
}
