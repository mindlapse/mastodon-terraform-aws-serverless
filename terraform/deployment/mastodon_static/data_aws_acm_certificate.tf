data "aws_acm_certificate" "cloudfront_cert" {
  provider    = aws.us-east-1
  domain      = var.web_domain
  types       = ["AMAZON_ISSUED"]
  statuses    = ["ISSUED"]
  key_types   = ["EC_prime256v1"]
  most_recent = true
}