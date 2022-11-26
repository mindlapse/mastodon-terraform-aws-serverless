
resource "aws_s3_bucket" "access_logs" {
  bucket        = "${local.prefix_hyphen}-access-logs"
  force_destroy = false
}