# Security Group to the bastion server
resource "aws_security_group" "bastion" {
  name        = "bastion-${var.vpc_name}"
  description = "Allows SSH access to the bastion server"

  vpc_id = aws_vpc.default.id

  ingress {
    from_port = 22 # Specify the port you use for SSH
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "112.154.140.25/32" # Change here to your office or house ...
    ]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http port any outbound"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https port any outbound"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = {
    Name = "bastion-${var.vpc_name}"
  }
}

# Security Group from the bastion server
# This will be attached to the private instance which user wants to access through bastion host
resource "aws_security_group" "bastion_aware" {
  name        = "bastion_aware-${var.vpc_name}"
  description = "Allows SSH access from the Bastion server"

  vpc_id = aws_vpc.default.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastionAware-${var.vpc_name}"
  }
}

