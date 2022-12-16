data "aws_lb_listener" "listener" {
  count = var.container_port == null ? 0 : 1
  arn   = var.listener_arn
}