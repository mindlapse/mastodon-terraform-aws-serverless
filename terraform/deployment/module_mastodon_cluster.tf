module "mastodon_cluster" {
  source  = "./mastodon_cluster"
  env     = var.env
  product = var.product

  ecr_puma_url          = aws_ecr_repository.mastodon.repository_url
  puma_target_group_arn = module.fargate_alb.target_group_arn

  vpc_id     = var.vpc_id
  subnet_ids = data.aws_subnets.subnets.ids

  force_new_deployment = var.force_new_deployment
}