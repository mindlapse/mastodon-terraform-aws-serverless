resource "aws_route_table_association" "route" {
  count          = var.num_azs
  route_table_id = aws_vpc.vpc.default_route_table_id
  subnet_id      = aws_subnet.public[count.index].id
}