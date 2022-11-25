resource "aws_default_route_table" "routes" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
}
