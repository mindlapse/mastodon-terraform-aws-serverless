
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = data.aws_s3_bucket.bucket.bucket
  policy = data.aws_iam_policy_document.allow_cloudfront.json
}
