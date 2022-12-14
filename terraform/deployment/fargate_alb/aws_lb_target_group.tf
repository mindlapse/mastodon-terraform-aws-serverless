resource "aws_lb_target_group" "ecs" {
  name        = "${local.prefix_hyphen}-fargate-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  load_balancing_algorithm_type = "least_outstanding_requests"
  protocol_version              = "HTTP1"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 20
    unhealthy_threshold = 3
  }
}

