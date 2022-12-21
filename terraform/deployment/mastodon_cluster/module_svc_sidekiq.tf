module "svc_sidekiq" {
  source = "./svc/fargate_svc_single_task"

  product = var.product
  env     = var.env

  vpc_id       = var.vpc_id
  subnet_ids   = var.subnet_ids
  listener_arn = null

  simple_name = "sidekiq"
  #   container_port       = 4000
  desired_count        = var.count_sidekiq
  force_new_deployment = var.force_new_deployment

  cpu = 256
  mem = 1024

  ecs_cluster_name = aws_ecs_cluster.cluster.name
  ecr_image_url    = var.ecr_url

  working_directory    = "/opt/mastodon"
  health_check_command = ["CMD-SHELL", "ps aux | grep '[s]idekiq' || false"]
  run_command          = ["bash", "-c", "rm -f /opt/mastodon/tmp/pids/server.pid; bundle exec sidekiq"]
  #   environment = [{
  #     "name" : "ALTERNATE_IP_RANGES",
  #     "value" : join(",", [for s in data.aws_subnet.subnet : s.cidr_block])
  #   }]
  user = "mastodon"

}
