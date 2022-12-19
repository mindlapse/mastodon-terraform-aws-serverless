output "bucket_regional_domain_name" {
  description = "The bucket's regional domain name"
  value       = module.simple_bucket.bucket_regional_domain_name
}

output "bucket_name" {
  description = "The bucket's name"
  value       = module.simple_bucket.bucket
}

output "bucket_arn" {
  description = "The bucket ARN"
  value       = module.simple_bucket.bucket_arn
}
