terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
  default_tags {
    tags = {
      PRODUCT = var.product
      ENV     = var.env
    }
  }
}


module "deployment" {
  source = "./deployment"

  product = var.product
  env     = var.env

  domain         = var.domain
  hosted_zone_id = var.hosted_zone_id
  cert_acm_arn   = var.acm_cert_arn
  vpc_id         = var.vpc_id

  force_new_deployment = true
}
