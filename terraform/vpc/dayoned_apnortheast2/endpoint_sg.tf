########### Security group for VPC Endpoint
#resource "aws_security_group" "secretsmanager_vpc_endpoint" {
#  name = "secretsmanager_vpc_endpoint-${var.vpc_name}"
#  vpc_id = aws_vpc.default.id
#
#  ingress {
#    from_port = 443
#    to_port = 443
#    protocol = "TCP"
#
#    cidr_blocks = [
#      "10.0.0.0/8"
#    ]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["10.0.0.0/8"]
#    description = "Internal outbound any traffic"
#  }
#
#  tags = {
#    Name = "secretsmanager_vpc_endpoint-${var.vpc_name}"
#  }
#}
#
