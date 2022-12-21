

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "${local.prefix}_${var.simple_name}_scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {

    # (Required) Target value for the metric.
    target_value = var.cpu_threshold

    # (Optional) Whether scale in by the target tracking policy is disabled. 
    # If the value is true, scale in is disabled and the target tracking policy won't remove 
    # capacity from the scalable resource. Otherwise, scale in is enabled and the target 
    # tracking policy can remove capacity from the scalable resource. The default value is false.
    disable_scale_in = false

    # (Optional) Amount of time, in seconds, after a scale in activity completes before another scale in activity can start.
    scale_in_cooldown = 180

    # (Optional) Amount of time, in seconds, after a scale out activity completes before another scale out activity can start.
    scale_out_cooldown = 180

    # (Optional) Custom CloudWatch metric. Documentation can be found at: AWS Customized Metric Specification. See supported fields below.
    # customized_metric_specification {}

    # (Optional) Predefined metric. See supported fields below.
    predefined_metric_specification {

      # (Required) Metric type.
      predefined_metric_type = "ECSServiceAverageCPUUtilization"

      # (Optional) Reserved for future use if the predefined_metric_type is not ALBRequestCountPerTarget.
      # If the predefined_metric_type is ALBRequestCountPerTarget, you must specify this argument.
      # Documentation can be found at: AWS Predefined Scaling Metric Specification.
      # Must be less than or equal to 1023 characters in length.
      # resource_label =
    }

  }
}