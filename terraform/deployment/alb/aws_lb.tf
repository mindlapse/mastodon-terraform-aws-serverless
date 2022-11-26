resource "aws_lb" "alb" {

  name = "${local.prefix_hyphen}-mastodon"

  internal = false

  load_balancer_type = "application"

  security_groups = [var.alb_security_group_id]

  dynamic "access_logs" {
    for_each = var.access_logs ? ["foo"] : []

    content {
      bucket  = var.access_logs ? module.access_logs[0].bucket : null
      prefix  = null
      enabled = var.access_logs
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_ids

    content {
      subnet_id = subnet_mapping.value
    }
  }

  idle_timeout = 60

  enable_deletion_protection = false

  enable_http2 = true

}