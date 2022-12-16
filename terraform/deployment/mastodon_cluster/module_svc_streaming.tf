module "svc_streaming" {
  source = "./svc/fargate_svc_single_task"

  product = var.product
  env     = var.env

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  listener_arn   = var.listener_arn
  route_priority = 1
  path_pattern   = "/api/v1/streaming*"

  simple_name          = "streaming"
  container_port       = 4000
  desired_count        = var.count_streaming
  force_new_deployment = var.force_new_deployment

  cpu = 256
  mem = 512

  ecs_cluster_arn = aws_ecs_cluster.cluster.arn
  ecr_image_url   = var.ecr_url

  working_directory    = "/opt/mastodon"
  health_check_command = ["CMD-SHELL", "wget -q --spider --proxy=off localhost:4000/api/v1/streaming/health || exit 1"]
  run_command          = ["bash", "-c", "node ./streaming"]
  #   environment = [{
  #     "name" : "ALTERNATE_IP_RANGES",
  #     "value" : join(",", [for s in data.aws_subnet.subnet : s.cidr_block])
  #   }]
  user = "mastodon"

}