resource "aws_cloudwatch_log_group" "logs" {
  name              = "${local.prefix}_${var.simple_name}"
  retention_in_days = 14
}
