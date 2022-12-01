module "user_uploads" {
    source = "./user_uploads"

    product = var.product
    env = var.env
    name = "uploads"
}
