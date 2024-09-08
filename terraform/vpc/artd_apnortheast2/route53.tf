resource "aws_route53_zone" "internal" {
  name    = var.internal_domain
  comment = "${local.vpc_name} - Managed by Terraform"

  vpc {
    vpc_id = aws_vpc.default.id
  }
}
