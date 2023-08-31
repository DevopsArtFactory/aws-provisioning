# AWS Route53 Zone 
resource "aws_route53_zone" "lguplus_link" {
  name    = "lguplus.link"
  comment = "HostedZone created by Route53 Registrar - Manged Terraform"
}
