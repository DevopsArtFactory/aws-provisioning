############ Security Group For Internal LB
resource "aws_security_group" "internal_lb" {
  name        = "${var.service_name}-${var.vpc_name}-int"
  description = "${var.service_name} internal LB SG"
  vpc_id      = var.target_vpc

  # If you don't want to use HTTPS then remove this block

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal outbound any traffic"
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

    # Allow internal LB Only for ec2 instance
    security_groups = [
      aws_security_group.internal_lb.id,
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

#################### Internal ALB
resource "aws_lb" "internal" {
  name     = "${var.service_name}-${var.shard_id}-int"
  subnets  = var.private_subnets
  internal = true

  # For internal LB,
  # Home SG (Includes Office IPs) could be added if this service is internal service.
  security_groups = [
    aws_security_group.internal_lb.id,
    var.home_sg,
  ]

  # For HTTP service, application LB is recommended.
  # You could use other load_balancer_type if you want.
  load_balancer_type = "application"

  tags = var.lb_variables.internal_lb.tags[var.shard_id]
}

#################### Internal LB Target Group 
resource "aws_lb_target_group" "internal" {
  name                 = "${var.service_name}-${var.shard_id}-int"
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

  tags = var.lb_variables.internal_lb_tg.tags[var.shard_id]

}


#################### Listener for HTTP service
resource "aws_lb_listener" "internal_80" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.internal.arn
    type             = "forward"
  }
}

#################### Route53 Record
resource "aws_route53_record" "internal_dns" {
  zone_id        = var.route53_internal_zone_id
  name           = var.route53_internal_domain
  type           = "A"
  set_identifier = var.aws_region

  latency_routing_policy {
    region = var.aws_region
  }

  alias {
    name                   = aws_lb.internal.dns_name
    zone_id                = aws_lb.internal.zone_id
    evaluate_target_health = true
  }
}

##### ASG

resource "aws_launch_template" "lt" {
  name_prefix   = "${var.service_name}-${var.vpc_name}-LT"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.ec2.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.service_name}-${var.vpc_name}-LaunchTemplate"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"

  }

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.private_subnets

  target_group_arns = [aws_lb_target_group.internal.arn]

  tag {
    key                 = "Name"
    value               = "${var.service_name}-${var.vpc_name}-asg"
    propagate_at_launch = true
  }
}
