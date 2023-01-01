module "mastodon_cluster" {
  source  = "./mastodon_cluster"
  env     = var.env
  product = var.product

  ecr_url = aws_ecr_repository.mastodon.repository_url

  vpc_id       = var.vpc_id
  subnet_ids   = data.aws_subnets.subnets.ids
  listener_arn = module.fargate_alb.listener_arn

  count_puma      = 1
  count_streaming = 1
  count_sidekiq   = 1

  force_new_deployment = var.force_new_deployment
  alb_domain           = var.alb_domain
}