module "appautoscaling" {
  source = "./appautoscaling"

  product     = var.product
  env         = var.env
  simple_name = var.simple_name

  cluster_name  = var.ecs_cluster_name
  service_name  = aws_ecs_service.svc.name
  max_capacity  = 10
  cpu_threshold = 80
}
