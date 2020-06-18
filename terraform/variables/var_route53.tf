variable "r53_variables" {
  default = {
    prod = {
      devopsartfactory_com_zone_id = "Z03407373NYH46ZMHFM7O"

      star_devopsartfactory_com_acm_arn_apnortheast2 = "arn:aws:acm:ap-northeast-2:816736805842:certificate/9d4a371f-80c5-4087-9cb5-b2636f554da7"
      star_devopsartfactory_com_acm_arn_useast1      = "arn:aws:acm:us-east-1:816736805842:certificate/8881601f-3f98-40d1-ab4f-b3402f163230"
      www_devopsartfactory_com_acm_arn_useast1       = ""
    }
  }
}

