output "bucket" {
  description = "Name of the bucket"
  value       = aws_s3_bucket.bucket.bucket
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_regional_domain_name" {
  description = "The bucket's regional domain name"
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}