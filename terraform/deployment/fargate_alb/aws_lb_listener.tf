
resource "aws_lb_listener" "https" {
  load_balancer_arn = module.alb.alb_arn

  port            = "443"
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn = var.cert_acm_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<html><body style='background-color:#202124;color:white;'>under maintenance</body></html>"
      status_code  = 404
    }
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.alb_arn

  port     = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
