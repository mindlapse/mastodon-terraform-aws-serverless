resource "aws_iam_user" "s3_uploads" {
  name = "${local.prefix}_s3_uploads"
}
