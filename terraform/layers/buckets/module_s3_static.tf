module "s3_static" {
  source = "./s3_static"

  env     = var.env
  product = var.product
}