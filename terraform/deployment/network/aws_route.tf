resource "aws_route" "route" {
  route_table_id         = aws_default_route_table.routes.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
