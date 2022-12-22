module "appautoscaling" {
  source = "./scheduled_scaling"

  product     = var.product
  env         = var.env
  simple_name = "puma_newday"

  cluster_name  = aws_ecs_cluster.cluster.name
  service_name  = module.svc_puma.ecs_service_name

  scale_up_cron = "cron(55 23 * * ? *)"
  scale_dn_cron = "cron(25 0 * * ? *)"

  scale_up_min_instances = 5
  scale_dn_min_instances = 1
  max_instances = 10
}
