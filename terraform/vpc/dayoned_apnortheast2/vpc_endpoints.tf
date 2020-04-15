#resource "aws_vpc_endpoint" "s3_endpoint" {
#  vpc_id       = aws_vpc.default.id
#  service_name = "com.amazonaws.${var.aws_region}.s3"
#}
#
#resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
#  count           = length(var.availability_zones)
#  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
#  route_table_id  = aws_route_table.private[count.index].id
#}
#
#resource "aws_vpc_endpoint" "dynamodb_endpoint" {
#  vpc_id       = aws_vpc.default.id
#  service_name = "com.amazonaws.${var.aws_region}.dynamodb"
#}
#
#resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_routetable" {
#  count           = length(var.availability_zones)
#  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
#  route_table_id  = aws_route_table.private[count.index].id
#}
#
#resource "aws_vpc_endpoint" "apigateway_endpoint" {
#  vpc_id            = aws_vpc.default.id
#  service_name      = "com.amazonaws.${var.aws_region}.execute-api"
#  vpc_endpoint_type = "Interface"
#
#  security_group_ids = [
#    "sg-0529f891ddeb0b237",
#  ]
#
#  private_dns_enabled = true
#  auto_accept         = true
#}
#
#resource "aws_vpc_endpoint_subnet_association" "apigateway_endpoint" {
#  count           = length(var.availability_zones)
#  vpc_endpoint_id = aws_vpc_endpoint.apigateway_endpoint.id
#  subnet_id       = element(aws_subnet.private.*.id, count.index)
#}
#
#
#resource "aws_vpc_endpoint" "secretsmanager_endpoint" {
#  vpc_id = aws_vpc.default.id
#  service_name = "com.amazonaws.${var.aws_region}.secretsmanager"
#  vpc_endpoint_type = "Interface"
#
#  security_group_ids = [
#    aws_security_group.secretsmanager_vpc_endpoint.id
#  ]
#
#  private_dns_enabled = true
#  auto_accept = true
#
#}
#
#resource "aws_vpc_endpoint_subnet_association" "secretsmanager_endpoint" {
#  count           = length(var.availability_zones_without_b)
#  vpc_endpoint_id = aws_vpc_endpoint.secretsmanager_endpoint.id
#  subnet_id = aws_subnet.private[count.index].id
#}
