output "bucket" {
  description = "Name of the bucket"
  value       = aws_s3_bucket.bucket.bucket
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.bucket.arn
}