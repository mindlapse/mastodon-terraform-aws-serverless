module "mastodon_static" {
  source = "./mastodon_static"

  env         = var.env
  product     = var.product
  alb_domain  = module.fargate_alb.alb_domain
  bucket_name = "${local.prefix_hyphen}-static"

  cloudfront_denylist = var.cloudfront_denylist

  hosted_zone_id = var.hosted_zone_id
  web_domain     = var.domain
}
