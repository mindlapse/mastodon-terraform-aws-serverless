output "listener_arn" {
  value = aws_lb_listener.https.arn
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_domain" {
  value = var.alb_domain
}