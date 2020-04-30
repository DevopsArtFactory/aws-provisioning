# AWS Route53 Zone 
resource "aws_route53_zone" "dayonedevops_com" {
  name = "dayonedevops.com"
}

# MX Record for G. Suite
resource "aws_route53_record" "dayonedevops_com_mx" {
  zone_id = aws_route53_zone.dayonedevops_com.zone_id
  name    = "dayonedevops.com"
  type    = "MX"
  ttl     = "3600"
  records = [
    "1 ASPMX.L.GOOGLE.COM.",
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
    "10 ALT3.ASPMX.L.GOOGLE.COM.",
    "10 ALT4.ASPMX.L.GOOGLE.COM."
  ]
}

# CNAME Record Example
resource "aws_route53_record" "app_dayonedevops_com" {
  zone_id = aws_route53_zone.dayonedevops_com.zone_id
  name    = "app.dayonedevops.com."
  type    = "CNAME"
  ttl     = "300"
  records = ["www.dayonedevops.com"]
}

resource "aws_route53_record" "test_dayonedevops_com" {
  zone_id = aws_route53_zone.dayonedevops_com.zone_id
  name    = "test.dayonedevops.com."
  type    = "CNAME"
  ttl     = "300"
  records = ["www.dayonedevops.com"]
}
