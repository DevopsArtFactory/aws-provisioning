############ Security Group For External LB
resource "aws_security_group" "external_lb" {
  name        = "${var.service_name}-${var.vpc_name}-ext"
  description = "${var.service_name} external LB SG"
  vpc_id      = var.target_vpc

  # Only allow access from IPs or SGs you specifiy in ext_lb_ingress_cidrs variables
  # If you don't want to use HTTPS then remove this block
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ext_lb_ingress_cidrs
    description = "External service https port"
  }


  # Allow 80 port 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ext_lb_ingress_cidrs
    description = "External service http port"
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

  # Only allow access from IPs or SGs you specifiy in ext_lb_ingress_cidrs variables
  # If you don't want to use HTTPS then remove this block

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "External service http port"
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


################## Security Group for EC2
resource "aws_security_group" "ec2" {
  name        = "${var.service_name}-${var.vpc_name}"
  description = "${var.service_name} Instance Security Group"
  vpc_id      = var.target_vpc

  # Service Port will be passed via variable.
  ingress {
    from_port = var.service_port
    to_port   = var.service_port
    protocol  = "tcp"

    # Allow external LB Only for ec2 instance
    security_groups = [
      aws_security_group.external_lb.id,
    ]

    description = "Port Open for ${var.service_name}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internal outbound traffic"
  }

  tags = {
    Name  = "${var.service_name}-${var.vpc_name}-sg"
    app   = var.service_name
    stack = var.vpc_name
  }
}
############## internal NLB
resource "aws_lb" "internal" {
  name               = "${var.service_name}-${var.shard_id}-nlb-int"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.private_subnets

  security_groups = [
    aws_security_group.internal_lb.id
  ]

  tags = var.lb_variables.external_lb.tags[var.shard_id]

}


resource "aws_lb_target_group" "internal" {
  name                 = "${var.service_name}-${var.shard_id}-int"
  port                 = var.service_port
  protocol             = "TCP"
  vpc_id               = var.target_vpc
  slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]

  # Change the health check setting
  health_check {
    interval            = 15
    port                = var.healthcheck_port
    path                = "/"
    timeout             = 3
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = var.lb_variables.internal_lb_tg.tags[var.shard_id]

}

resource "aws_lb_listener" "internal_80" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.internal.arn
    type             = "forward"
  }

}

#################### External ALB
resource "aws_lb" "external" {
  name     = "${var.service_name}-${var.shard_id}-ext"
  subnets  = var.public_subnets
  internal = false

  # For external LB,
  # Home SG (Includes Office IPs) could be added if this service is internal service.
  security_groups = [
    aws_security_group.external_lb.id,
    var.home_sg,
  ]

  # For HTTP service, application LB is recommended.
  # You could use other load_balancer_type if you want.
  load_balancer_type = "application"

  tags = var.lb_variables.external_lb.tags[var.shard_id]
}

#################### External LB Target Group 
resource "aws_lb_target_group" "external" {
  name                 = "${var.service_name}-${var.shard_id}-ext"
  port                 = var.service_port
  protocol             = "HTTP"
  vpc_id               = var.target_vpc
  slow_start           = var.lb_variables.target_group_slow_start[var.shard_id]
  deregistration_delay = var.lb_variables.target_group_deregistration_delay[var.shard_id]

  # Change the health check setting 
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


#################### Listener for HTTPS service
resource "aws_lb_listener" "external_443" {
  load_balancer_arn = aws_lb.external.arn
  port              = "443"
  protocol          = "HTTPS"

  # If you want to use HTTPS, then you need to add certificate_arn here.
  certificate_arn = var.acm_external_ssl_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.external.arn
    type             = "forward"
  }
}


#################### Listener for HTTP service
resource "aws_lb_listener" "external_80" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  # This is for redirect 80. 
  # This means that it will only allow HTTPS(443) traffic
  default_action {
    type = "redirect"

    redirect {
      port     = "443"
      protocol = "HTTPS"
      # 301 -> Permanant Movement
      status_code = "HTTP_301"
    }
  }
}

#################### Route53 Record
resource "aws_route53_record" "external_dns" {
  zone_id        = var.route53_external_zone_id
  name           = var.domain_name
  type           = "A"
  set_identifier = var.aws_region

  latency_routing_policy {
    region = var.aws_region
  }

  alias {
    name                   = aws_lb.external.dns_name
    zone_id                = aws_lb.external.zone_id
    evaluate_target_health = true
  }
}

