
resource "aws_s3_bucket_acl" "source" {
  bucket = aws_s3_bucket.access_logs.id
  acl    = "private"
}
