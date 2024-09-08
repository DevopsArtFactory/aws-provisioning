resource "aws_vpc" "default" {
  cidr_block                       = "10.${var.cidr_numeral}.0.0/16"
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true


  tags = {
    Name = "vpc-${local.vpc_name}"
  }
}


# using IPv6
# resource "aws_egress_only_internet_gateway" "default" {
#   vpc_id = aws_vpc.default.id

#   tags = {
#     Name = "egress-igw-${local.vpc_name}"
#   }
# }
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "igw-${local.vpc_name}"
  }
}

resource "aws_eip" "nat" {
  count  = length(var.availability_zones)
  domain = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)

  allocation_id = element(aws_eip.nat.*.id, count.index)

  subnet_id = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "NAT-GW${count.index}-${local.vpc_name}"
  }
}

# PUBLIC SUBNETS
resource "aws_subnet" "public" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  cidr_block              = "10.${var.cidr_numeral}.${var.cidr_numeral_public[count.index]}.0/20"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, var.cidr_numeral_public[count.index])
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public${count.index}-${local.vpc_name}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# PUBLIC SUBNETS - Default route
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "publicrt-${local.vpc_name}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


# PRIVATE SUBNETS
resource "aws_subnet" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  cidr_block        = "10.${var.cidr_numeral}.${var.cidr_numeral_private[count.index]}.0/20"
  ipv6_cidr_block   = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, var.cidr_numeral_private[count.index])
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private${count.index}-${local.vpc_name}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "private${count.index}rt-${local.vpc_name}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

# DB PRIVATE SUBNETS
resource "aws_subnet" "private_db" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  cidr_block        = "10.${var.cidr_numeral}.${var.cidr_numeral_private_db[count.index]}.0/20"
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "db-private${count.index}-${local.vpc_name}"
  }
}

resource "aws_route_table" "private_db" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "privatedb${count.index}rt-${local.vpc_name}"
  }
}

resource "aws_route_table_association" "private_db" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_db.*.id, count.index)
  route_table_id = element(aws_route_table.private_db.*.id, count.index)
}
