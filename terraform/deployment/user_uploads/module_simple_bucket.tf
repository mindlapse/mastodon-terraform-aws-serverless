module "simple_bucket" {
  source  = "./simple_bucket"
  product = var.product
  env     = var.env
  name    = var.name
}