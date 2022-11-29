resource "aws_lb_target_group" "ecs" {
  name        = "${local.prefix_hyphen}-fargate-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  load_balancing_algorithm_type = "least_outstanding_requests"
  protocol_version              = "HTTP1"
}

