module "fargate_alb" {
  source       = "./fargate_alb"
  env          = var.env
  product      = var.product
  subnet_ids   = slice(tolist(data.aws_subnets.subnets.ids), 0, 2) # max two AZs
  access_logs  = false
  cert_acm_arn = var.cert_acm_arn
  vpc_id       = var.vpc_id

  hosted_zone_id = var.hosted_zone_id
  web_domain     = var.domain

}