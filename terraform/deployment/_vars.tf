variable "env" {
  type        = string
  description = "[dev, prod]"
}

variable "product" {
  type        = string
  description = "product codename, e.g. 'ta'"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to place resources"
}

variable "domain" {
  type        = string
  description = "The domain name e.g. 'mastodon.solar'"
}

/* Hosting */
variable "hosted_zone_id" {
  type        = string
  description = "The ID of the hosted zone that will receive an aws_route53_record"
}

variable "cert_acm_arn" {
  type        = string
  description = "ARN of the ACM Certificate to use with the domain"
}

variable "force_new_deployment" {
  type        = bool
  description = "Set to true enable force_new_deployment on services"
  default     = false
}