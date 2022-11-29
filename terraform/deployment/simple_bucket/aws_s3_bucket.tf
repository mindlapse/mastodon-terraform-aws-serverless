
resource "aws_s3_bucket" "bucket" {
  bucket        = "${local.prefix_hyphen}-${var.name}"
  force_destroy = false
}