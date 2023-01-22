module "svc_puma" {
  source = "./svc/fargate_svc_single_task"

  product = var.product
  env     = var.env

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  listener_arn   = var.listener_arn
  route_priority = 2
  path_pattern   = "/*"

  simple_name          = "puma"
  container_port       = 3000
  desired_count        = var.count_puma
  force_new_deployment = var.force_new_deployment

  cpu = 512
  mem = 1024

  ecs_cluster_name = aws_ecs_cluster.cluster.name
  ecr_image_url    = var.ecr_url

  working_directory    = "/opt/mastodon"
  health_check_command = ["CMD-SHELL", "wget -q --spider --proxy=off localhost:3000/health || exit 1"]
  run_command          = ["bash", "-c", "rm -f /opt/mastodon/tmp/pids/server.pid; bundle exec rails s -p 3000"]
  environment = [{
    "name" : "ALTERNATE_IP_RANGES",
    "value" : join(",", [for s in data.aws_subnet.subnet : s.cidr_block])
    }, {
    "name" : "ALTERNATE_DOMAINS",
    "value" : var.alb_domain
  }]
  user = "mastodon"
}