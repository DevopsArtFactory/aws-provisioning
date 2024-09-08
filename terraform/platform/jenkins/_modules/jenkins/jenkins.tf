resource "aws_security_group" "external_lb" {
  count    = var.enable_external ? 1 : 0
  name        = "${var.service_name}-${var.vpc_name}-ext"
  description = "${var.service_name} external LB SG"
  vpc_id      = var.target_vpc

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-ext"
    },
    var.project_tags
  )
}

resource "aws_security_group" "internal_lb" {
  count    = var.enable_internal ? 1 : 0
  name        = "${var.service_name}-${var.vpc_name}-int"
  description = "${var.service_name} internal LB SG"
  vpc_id      = var.target_vpc

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-int"
    },
    var.project_tags
  )
}

resource "aws_security_group" "jenkins" {
  name        = "${var.service_name}-${var.vpc_name}"
  description = "${var.service_name} Instance Security Group"
  vpc_id      = var.target_vpc

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    security_groups = var.enable_external ?   [
      aws_security_group.external_lb[0].id,
    ] : [
      aws_security_group.internal_lb[0].id,
    ]
  }

  ingress {
    from_port = 50000
    to_port   = 50000
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-sg"
    },
    var.project_tags
  )
}

#####################

####### external ALB
resource "aws_lb" "external" {
  count    = var.enable_external ? 1 : 0
  name     = "${var.service_name}-${var.shard_id}-ext"
  subnets  = var.public_subnets
  internal = false
  security_groups = [
    aws_security_group.external_lb[0].id,
  ]
  load_balancer_type = "application"
  ip_address_type    = "ipv4"

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-external-lb"
    },
    var.project_tags
  )
}

resource "aws_lb_target_group" "external" {
  count                = var.enable_external ? 1 : 0
  name                 = "${var.service_name}-${var.shard_id}-ext"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = var.target_vpc
  slow_start           = 30
  deregistration_delay = 180

  health_check {
    interval            = 10
    port                = 8080
    path                = "/login"
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-external-tg"
    },
    var.project_tags
  )
}

resource "aws_lb_listener" "external_443" {
  count             = var.enable_external ? 1 : 0
  load_balancer_arn = aws_lb.external[0].arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = var.ssl_certificate_id

  default_action {
    target_group_arn = aws_lb_target_group.external[0].arn
    type             = "forward"
  }
}

#####################

####### internal ALB
resource "aws_lb" "internal" {
  count    = var.enable_internal ? 1 : 0
  name     = "${var.service_name}-${var.shard_id}-int"
  subnets  = var.private_subnets
  internal = true
  security_groups = [
    aws_security_group.internal_lb[0].id,
  ]
  load_balancer_type = "application"
  ip_address_type    = "ipv4"

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-internal-lb"
    },
    var.project_tags
  )
}

resource "aws_lb_target_group" "internal" {
  count                = var.enable_internal ? 1 : 0
  name                 = "${var.service_name}-${var.shard_id}-int"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = var.target_vpc
  slow_start           = 30
  deregistration_delay = 180

  health_check {
    interval            = 10
    port                = 8080
    path                = "/login"
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = merge(
    {
      Name = "${var.service_name}-${var.vpc_name}-internal-tg"
    },
    var.project_tags
  )
}

resource "aws_lb_listener" "internal_443" {
  count             = var.enable_internal ? 1 : 0
  load_balancer_arn = aws_lb.internal[0].arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = var.ssl_certificate_id

  default_action {
    target_group_arn = aws_lb_target_group.internal[0].arn
    type             = "forward"
  }
}


resource "aws_route53_record" "jenkins_regional_ext_dns" {
  count   = var.enable_external ? 1 : 0
  zone_id = var.route53_external_zone_id
  name    = var.service_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.external[0].dns_name]
}


resource "aws_route53_record" "jenkins_regional_int_dns" {
  count   = var.enable_internal ? 1 : 0
  zone_id = var.route53_external_zone_id
  name    = var.service_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.internal[0].dns_name]
}
