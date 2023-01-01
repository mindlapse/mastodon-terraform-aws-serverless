variable "aws_profile" {
  type        = string
  description = "The name an AWS profile you created for Terraform to use for deployment"
}

variable "region" {
  type        = string
  description = "The AWS region where mastodon will be deployed. e.g. ca-central-1"
}

variable "vpc_id" {
  type        = string
  description = "The VPC in which resources should be created.  See layers/network for the prerequisite module to create a VPC."
}

variable "product" {
  type        = string
  default     = "mast"
  description = "A product used for prefixing resource names."
}

variable "env" {
  type        = string
  default     = "prod"
  description = "The environment name used for prefixing resource names, with the product variable."
}

variable "domain" {
  type        = string
  description = "The domain name of the mastodon deployment"
}

variable "alb_domain" {
  type        = string
  description = "The domain name for the ALB"
}

variable "hosted_zone_id" {
  type        = string
  description = "The ID of the hosted zone that will receive an aws_route53_record"
}

variable "acm_cert_arn" {
  type        = string
  description = "The ARN of the certificate for your domain to use with HTTPS listeners"
}


variable "cloudfront_cert_arn" {
  type        = string
  description = "The ARN of the certificate to use with the CloudFront distribution (must be in us-east-1)"
}

variable "cloudfront_denylist" {
  type        = list(string)
  description = "Deny serving these countries (using ISO-3166 Alpha-2 codes)"
}

variable "cloudfront_domain" {
  type        = string
  description = "the domain (e.g. files.mastodon.solar)"
}