resource "aws_security_group" "external_lb" {
  name        = "${var.service_name}-${var.vpc_name}-ext"
  description = "${var.service_name} external LB SG"
  vpc_id      = var.target_vpc

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ext_lb_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }


  tags = var.sg_variables.external_lb.tags[var.shard_id]
}

resource "aws_security_group" "ec2" {
  name        = "${var.service_name}-${var.vpc_name}"
  description = "${var.service_name} Instance Security Group"
  vpc_id      = var.target_vpc

  ingress {
    from_port = var.service_port
    to_port   = var.service_port
    protocol  = "tcp"

    security_groups = [
      aws_security_group.external_lb.id,
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

  tags = var.sg_variables.ec2.tags[var.shard_id]
}

####### External ALB
resource "aws_lb" "external" {
  name     = "${var.service_name}-${var.shard_id}-ext"
  subnets  = var.public_subnets
  internal = false
  security_groups = [
    aws_security_group.external_lb.id
  ]
  load_balancer_type = "application"

  tags = var.lb_variables.external_lb.tags[var.shard_id]
}

resource "aws_lb_target_group" "external" {
  name                 = "${var.service_name}-${var.shard_id}-ext"
  port                 = var.service_port
  protocol             = "HTTP"
  vpc_id               = var.target_vpc
  slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]

  # This healthcheck path will get 403 error so that target is unhealthy
  # But it is okay because all instances in the target group are unhealty, then traffics are evenly passed to all instances.
  # If you want healthy status, then please use `/login` path
  health_check {
    interval            = 15
    port                = var.healthcheck_port
    path                = "/"
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = var.lb_variables.external_lb_tg.tags[var.shard_id]
}

resource "aws_lb_listener" "external_443" {
  load_balancer_arn = aws_lb.external.arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = var.acm_external_ssl_certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.external.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "external_80" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


# Route 53 Record 
resource "aws_route53_record" "regional_external_dns" {
  zone_id = var.route53_external_zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.external.dns_name]
}

