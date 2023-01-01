

/* Common parameters */

variable "product" {
  type        = string
  description = "product codename, e.g. 'mast'"
}

variable "env" {
  type        = string
  description = "[dev, prod]"
}


/* Hosting */
variable "hosted_zone_id" {
  type        = string
  description = "The ID of the hosted zone that will receive an aws_route53_record"
}

variable "alb_domain" {
  type        = string
  description = "The hostname for an A record in the given hosted zone, that will alias to the ALB, e.g. mastodon.xyz."
}



/* Listener parameters */

variable "cert_acm_arn" {
  type        = string
  description = "ARN of the ACM Certificate to use with the domain"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC, used with security groups"
}



/* ALB module parameters */


variable "subnet_ids" {
  type        = list(string)
  description = "The subnets to deploy the ALB to (one per AZ)"
}

variable "access_logs" {
  type        = bool
  default     = false
  description = "Set to true to enable access logs"
}


