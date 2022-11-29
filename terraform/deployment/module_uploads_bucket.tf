module "uploads_bucket" {
  source  = "./simple_bucket"
  product = var.product
  env     = var.env
  name    = "uploads"
}