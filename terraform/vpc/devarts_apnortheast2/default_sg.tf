# Default Security Group 
# This is the security group for most of instances should have 
resource "aws_security_group" "default" {
  name        = "default-${var.vpc_name}"
  description = "default group for ${var.vpc_name}"
  vpc_id      = aws_vpc.default.id

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https any outbound"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https any outbound"
  }

  # Instance should allow ifselt to send the log file to kafka
  egress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "kafka any outbound"
  }


  # Instance should allow ifselt to send the log file to elasticsearch
  egress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ElasticSearch any outbound"
  }

}

# Home Security Group 
# This will be usually attached to the web server that users in the office should access through browser..
# This is used for all users in the company to access to the resources in the office or home..
resource "aws_security_group" "home" {
  name        = "home"
  description = "Home Security Group for ${var.vpc_name}"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "180.71.174.152/32" # Change here to your office or house ...
    ]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "180.71.174.152/32" # Change here to your office or house ...
    ]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https any outbound"
  }
}

