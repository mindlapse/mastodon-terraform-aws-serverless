
module "cloudfront_s3" {
  source = "./cloudfront_s3"

  env     = var.env
  product = var.product

  cloudfront_domain   = var.cloudfront_domain
  acm_certificate_arn = var.cloudfront_cert_arn
  cloudfront_denylist = var.cloudfront_denylist
  hosted_zone_id      = var.hosted_zone_id

  bucket_name = module.user_uploads.bucket_name
}
