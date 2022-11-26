module "alb" {
  source                = "./alb"
  env                   = var.env
  product               = var.product
  subnet_ids            = slice(module.network.subnet_ids, 0, 2) # max two AZs
  alb_security_group_id = aws_security_group.mastodon_alb.id
  access_logs           = true
}