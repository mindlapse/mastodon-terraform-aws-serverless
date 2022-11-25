locals {
  prefix  = "mast"
  env     = "prod"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "ca-central-1"
  profile = "mastodon"
  default_tags {
    tags = {
      PREFIX = local.prefix
      ENV    = local.env
    }
  }
}


module "deployment" {
  source = "./deployment"

  product = "mast"
  env     = "prod"

  vpc_cidr_prefix    = "10.0"     # example: 10.0 is the prefix for 10.0.0.0/16
  container_insights = "disabled" # costs extra
}
