data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
    region = data.aws_region.current.name
    account_id = data.aws_caller_identity.current.account_id

    prefix = "${var.product}_${var.env}"

    tags = {
        PRODUCT = var.product
        ENV = var.env
    }
}