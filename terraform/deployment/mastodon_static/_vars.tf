variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "product" {
  type        = string
  description = "product codename, e.g. 'ta'"
}


variable "alb_domain" {
  type        = string
  description = "the domain (e.g. files.mastodon.social)"
}


# variable "hosted_zone_id" {
#   type        = string
#   description = "The ID of the hosted zone that will receive an aws_route53_record"
# }

variable "bucket_name" {
  type        = string
  description = "the name of the origin s3 bucket for the distribution (just the bucket name, not the ARN)"
}


variable "cloudfront_denylist" {
  type        = list(string)
  description = "Deny serving these countries (using ISO-3166 Alpha-2 codes)"
}


/* Hosting */

variable "hosted_zone_id" {
  type        = string
  description = "The ID of the hosted zone that will receive an aws_route53_record"
}

variable "web_domain" {
  type        = string
  description = "The hostname for an A record in the given hosted zone, that will alias to the ALB, e.g. mastodon.xyz."
}

