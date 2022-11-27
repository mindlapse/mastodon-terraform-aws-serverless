variable "aws_profile" {
    type = string
    description = "The name an AWS profile you created for Terraform to use for deployment"
}

variable "region" {
    type = string
    description = "The AWS region where mastodon will be deployed. e.g. ca-central-1"
}

variable "vpc_cidr_prefix" {
    type = string
    default = "10.0"
    description = "The prefix of the IP addresses used by the VPC.  The default 10.0 will create a VPC that spans 10.0.0.0/16."
}

variable "product" {
    type = string
    default = "mast"
    description = "A product used for prefixing resource names."
}

variable "env" {
    type = string
    default = "prod"
    description = "The environment name used for prefixing resource names, with the product variable."
}

variable "domain" {
    type = string
    description = "The domain name of the mastodon deployment"
}

variable "acm_cert_arn" {
    type = string
    description = "The ARN of the certificate for your domain to use with HTTPS listeners"
}
