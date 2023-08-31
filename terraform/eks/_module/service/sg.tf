resource "aws_security_group" "external_lb" {
  name        = "${var.service_name}-${var.vpc_name}-ext"
  description = "${var.service_name} external LB SG"
  vpc_id      = var.target_vpc

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ext_lb_ingress_cidrs
    description = "External inbound service traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal outbound any traffic"
  }

  tags = var.sg_variables.external_lb.tags[var.shard_id]
}

resource "aws_security_group" "internal_lb" {
  name        = "${var.service_name}-${var.vpc_name}-int"
  description = "${var.service_name} internal LB SG"
  vpc_id      = var.target_vpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal inbound service traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal outbound any traffic"
  }

  tags = var.sg_variables.internal_lb.tags[var.shard_id]
}


