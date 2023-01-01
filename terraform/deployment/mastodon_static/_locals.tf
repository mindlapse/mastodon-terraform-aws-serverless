data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  region     = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id

  prefix        = "${var.product}_${var.env}"
  prefix_hyphen = "${var.product}-${var.env}"

  s3_origin  = "s3_origin"
  alb_origin = "alb_origin"

  cache_seconds = 2419200 # 28 days

}
