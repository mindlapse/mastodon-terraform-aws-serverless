resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_prefix}.0.0/16"
}