variable "r53_variables" {
  default = {
    id = {
      devopsartfactory_com_zone_id = "Z03407373NYH46ZMHFM7O"

      star_devopsartfactory_com_acm_arn_apnortheast2 = "arn:aws:acm:ap-northeast-2:816736805842:certificate/9d4a371f-80c5-4087-9cb5-b2636f554da7"
      star_devopsartfactory_com_acm_arn_useast1      = "arn:aws:acm:us-east-1:816736805842:certificate/8881601f-3f98-40d1-ab4f-b3402f163230"
    }
    prod = {

      prod_devopsartfactory_com_zone_id                   = "Z048397936KDDQS9NZSTU"
      star_prod_devopsartfactory_com_acm_arn_apnortheast2 = "arn:aws:acm:ap-northeast-2:002202845208:certificate/b440dccd-4d95-4313-bc0d-f25f2b7648c3"

      www_devopsartfactory_com_acm_arn_useast1 = ""
    }
  }
}

