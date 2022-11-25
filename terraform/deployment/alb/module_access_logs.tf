module "access_logs" {
  count   = var.access_logs ? 1 : 0
  source  = "./access_logs"
  env     = var.env
  product = var.product
}