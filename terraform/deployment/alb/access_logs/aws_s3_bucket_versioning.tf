
resource "aws_s3_bucket_versioning" "source" {
  bucket = aws_s3_bucket.access_logs.id

  versioning_configuration {
    status = "Disabled"
  }
}
