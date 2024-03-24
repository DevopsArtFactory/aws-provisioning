
# Gateway Type Endpoint ( S3, DynamoDB )
## S3 Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.default.id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  tags = {
    Name = "s3-${var.shard_id}"
  }
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
  count           = length(var.availability_zones)
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id  = aws_route_table.private[count.index].id
}


## DynamoDB Endpoint
resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.default.id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"

  tags = {
    Name = "dynamodb-${var.shard_id}"
  }
}

# Add vpc endpoint to route table of private subnet
resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_routetable" {
  count           = length(var.availability_zones)
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
  route_table_id  = aws_route_table.private[count.index].id
}

/*
# Interface Type Endpoint 
# Security Group of VPC Endpoint (API Gateway)
resource "aws_security_group" "apigateway_vpc_endpoint_sg" {
  name   = "apigateway_vpc_endpoint-${var.vpc_name}"
  vpc_id = aws_vpc.default.id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "TCP"

    cidr_blocks = [
      "10.0.0.0/8"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal outbound any traffic"
  }

  tags = {
    Name = "apigateway-${var.vpc_name}"
  }
}

## API Gateway Endpoint
resource "aws_vpc_endpoint" "apigateway_endpoint" {
  vpc_id            = aws_vpc.default.id
  service_name      = "com.amazonaws.${var.aws_region}.execute-api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.apigateway_vpc_endpoint_sg.id
  ]

  private_dns_enabled = true
  auto_accept         = true

  tags = {
    Name = "apigateway-${var.shard_id}"
  }
}

resource "aws_vpc_endpoint_subnet_association" "apigateway_endpoint" {
  count           = length(var.availability_zones)
  vpc_endpoint_id = aws_vpc_endpoint.apigateway_endpoint.id
  subnet_id       = element(aws_subnet.private.*.id, count.index)
}

## Secrets Manager Endpoint
# Security Group of VPC Endpoint (Secrets Manager)
resource "aws_security_group" "secretsmanager_vpc_endpoint_sg" {
  name   = "secretsmanager_vpc_endpoint-${var.vpc_name}"
  vpc_id = aws_vpc.default.id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "TCP"

    cidr_blocks = [
      "10.0.0.0/8"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Internal outbound any traffic"
  }

  tags = {
    Name = "secretsmanager-${var.vpc_name}"
  }
}

# Secrets Manager VPC Endpoint
resource "aws_vpc_endpoint" "secretsmanager_endpoint" {
  vpc_id            = aws_vpc.default.id
  service_name      = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.secretsmanager_vpc_endpoint_sg.id
  ]

  private_dns_enabled = true
  auto_accept         = true

  tags = {
    Name = "secretsmanager-${var.shard_id}"
  }
}

resource "aws_vpc_endpoint_subnet_association" "secretsmanager_endpoint" {
  count           = length(var.availability_zones)
  vpc_endpoint_id = aws_vpc_endpoint.secretsmanager_endpoint.id
  subnet_id       = aws_subnet.private[count.index].id
}

*/
