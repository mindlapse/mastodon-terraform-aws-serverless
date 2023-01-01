
resource "aws_s3_bucket" "bucket" {
  bucket        = "${local.prefix_hyphen}-static"
  force_destroy = false
}