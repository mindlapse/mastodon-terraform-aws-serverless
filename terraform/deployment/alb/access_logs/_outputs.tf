output "bucket" {
  description = "Name of the access logs bucket"
  value       = aws_s3_bucket.source.bucket
}