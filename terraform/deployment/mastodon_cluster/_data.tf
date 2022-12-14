
data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}


data "aws_subnet" "subnet" {
  for_each = data.aws_subnet_ids.subnets.ids
  id       = each.value
}