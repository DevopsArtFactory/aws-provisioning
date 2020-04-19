variable "r53_variables" {
  default = {
    prod = {
      dayonedevops_com_zone_id = ""

      star_dayonedevops_com_acm_arn_apnortheast2 = ""
      star_dayonedevops_com_acm_arn_useast1      = ""
      www_dayonedevops_com_acm_arn_useast1       = ""
    }
  }
}

