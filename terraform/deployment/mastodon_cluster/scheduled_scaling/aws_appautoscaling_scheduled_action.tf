resource "aws_appautoscaling_scheduled_action" "scale_up" {
  name               = "${local.prefix}_${var.simple_name}_up"

  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  schedule           = var.scale_up_cron

  scalable_target_action {
    min_capacity = var.scale_up_min_instances
    max_capacity = var.max_instances
  }
}


resource "aws_appautoscaling_scheduled_action" "scale_dn" {
  name               = "${local.prefix}_${var.simple_name}_dn"

  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  schedule           = var.scale_dn_cron

  scalable_target_action {
    min_capacity = var.scale_dn_min_instances
    max_capacity = var.max_instances
  }
}
