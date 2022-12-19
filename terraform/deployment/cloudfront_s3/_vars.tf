variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "product" {
  type        = string
  description = "product codename, e.g. 'ta'"
}


variable "cloudfront_domain" {
  type        = string
  description = "the domain (e.g. files.mastodon.social)"
}

variable "hosted_zone_id" {
  type        = string
  description = "The ID of the hosted zone that will receive an aws_route53_record"
}

variable "bucket_name" {
  type        = string
  description = "the name of the origin s3 bucket for the distribution (just the bucket name, not the ARN)"
}

variable "comment" {
  type        = string
  default     = ""
  description = "A comment to give the distribution"
}

variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1."
}

variable "cloudfront_denylist" {
  type        = list(string)
  description = "Deny serving these countries (using ISO-3166 Alpha-2 codes)"
}
