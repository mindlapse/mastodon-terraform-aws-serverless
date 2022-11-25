
resource "aws_s3_bucket_acl" "source" {
  bucket = aws_s3_bucket.source.id
  acl    = "private"
}
