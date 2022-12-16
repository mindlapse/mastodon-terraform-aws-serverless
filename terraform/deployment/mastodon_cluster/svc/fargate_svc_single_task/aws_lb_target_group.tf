resource "aws_lb_target_group" "tg" {
  count       = var.container_port == null ? 0 : 1
  name        = "${local.prefix_hyphen}-fargate-tg-${var.simple_name}"
  port        = var.container_port
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
