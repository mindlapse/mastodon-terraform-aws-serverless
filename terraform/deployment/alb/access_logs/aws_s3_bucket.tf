
resource "aws_s3_bucket" "source" {
  bucket        = "${local.prefix_hyphen}-access-logs"
  force_destroy = false
}