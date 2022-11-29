module "alb" {
  source       = "./fargate_alb"
  env          = var.env
  product      = var.product
  subnet_ids   = slice(module.network.subnet_ids, 0, 2) # max two AZs
  access_logs  = false
  cert_acm_arn = var.cert_acm_arn
  vpc_id       = module.network.vpc_id
}