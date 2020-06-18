# Codebuild Default Security Group
resource "aws_security_group" "codebuild_default" {
  name        = "codebuild-default-${var.vpc_name}"
  description = "codebuild-default group for ${var.vpc_name}"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

