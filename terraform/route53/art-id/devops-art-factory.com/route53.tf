# AWS Route53 Zone 
resource "aws_route53_zone" "devopsartfactory_com" {
  name    = "devops-art-factory.com"
  comment = "HostedZone created by Route53 Registrar - Manged Terraform"
}

resource "aws_route53_record" "ns_prod_devops-art-factory_com" {
  zone_id = aws_route53_zone.devopsartfactory_com.zone_id
  name    = "prod"
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
