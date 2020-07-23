# AWS Route53 Zone 
resource "aws_route53_zone" "devopsartfactory_com" {
  name = "devops-art-factory.com"
}

# MX Record for G. Suite
resource "aws_route53_record" "devopsartfactory_com_mx" {
  zone_id = aws_route53_zone.devopsartfactory_com.zone_id
  name    = "devops-art-factory.com"
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

resource "aws_route53_record" "ns_prod_devops-art-factory_com" {
  zone_id = aws_route53_zone.devopsartfactory_com.zone_id
  name    = "releng"
  type    = "NS"
  ttl     = "300"
  records = [
    # Refer to Route53 Zone for `prod.devops-art-factory.com in `art-id`
    "ns-1626.awsdns-11.co.uk.",
    "ns-1184.awsdns-20.org.",
    "ns-378.awsdns-47.com.",
    "ns-619.awsdns-13.net."
  ]
}
