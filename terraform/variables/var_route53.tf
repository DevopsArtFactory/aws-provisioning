variable "r53_variables" {
  default = {
    prod = {
      dayonedevops_com_zone_id = "Z07279892AEB4RAPQCW8M"

      star_dayonedevops_com_acm_arn_apnortheast2 = "arn:aws:acm:ap-northeast-2:229438263680:certificate/89b65af1-d1b2-4130-b8ca-64f344da5f2a"
      star_dayonedevops_com_acm_arn_useast1      = "arn:aws:acm:us-east-1:229438263680:certificate/04de536d-0fac-4ba7-b706-574902343475"
      www_dayonedevops_com_acm_arn_useast1       = ""
    }
  }
}

