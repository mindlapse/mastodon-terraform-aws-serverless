
resource "aws_subnet" "public" {
  count             = var.num_azs
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_cidr_prefix}.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.zones.names[count.index]
}
