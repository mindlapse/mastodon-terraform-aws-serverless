output "bucket" {
  description = "Name of the bucket"
  value       = aws_s3_bucket.bucket.bucket
}