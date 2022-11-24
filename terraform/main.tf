terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = "ca-central-1"
    profile = "mastodon"
}


module "deployment" {
    source = "./deployment"

    product = "mast"
    env = "prod"
    vpc_cidr = "10.0.0.0/16"
}
