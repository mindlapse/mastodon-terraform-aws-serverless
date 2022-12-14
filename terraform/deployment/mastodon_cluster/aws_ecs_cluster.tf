resource "aws_ecs_cluster" "cluster" {
  name = "${local.prefix}_mastodon"

  setting {
    name  = "containerInsights"
    value = var.container_insights
  }
}
