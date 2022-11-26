resource "aws_s3_bucket_policy" "alb_access" {
  bucket = aws_s3_bucket.access_logs.id

  policy = data.aws_iam_policy_document.allow_access.json
}