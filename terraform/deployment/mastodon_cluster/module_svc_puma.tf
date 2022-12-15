module "svc_puma" {
  source = "./svc/fargate_svc_single_task"

  product = var.product
  env     = var.env

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  simple_name          = "puma"
  container_port       = var.port_puma
  desired_count        = var.count_puma
  force_new_deployment = var.force_new_deployment

  cpu = 256
  mem = 512

  ecs_cluster_arn  = aws_ecs_cluster.cluster.arn
  target_group_arn = var.puma_target_group_arn
  ecr_image_url    = var.ecr_puma_url

  working_directory    = "/opt/mastodon"
  health_check_command = ["CMD-SHELL", "wget -q --spider --proxy=off localhost:3000/health || exit 1"]
  run_command          = ["bash", "-c", "rm -f /opt/mastodon/tmp/pids/server.pid; bundle exec rails s -p 3000"]
  environment = [{
    "name" : "ALTERNATE_IP_RANGES",
    "value" : join(",", [for s in data.aws_subnet.subnet : s.cidr_block])
  }]
  user = "mastodon"
}

/*
module "svc_puma" {
    source = "./svc/fargate_svc_single_task"

    product = var.product
    env = var.env

    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids

    simple_name = "streaming"
    container_port = var.port_streaming
    desired_count = var.count_streaming
    force_new_deployment = var.force_new_deployment

    cpu = 256
    mem = 512

    ecs_cluster_arn = aws_ecs_cluster.cluster.arn
    target_group_arn = var.puma_target_group_arn        # TODO
    ecr_image_url = var.ecr_puma_url

    working_directory = "/opt/mastodon"
    health_check_command = ["CMD-SHELL", "wget -q --spider --proxy=off localhost:3000/health || exit 1"]
    run_command = ["bash", "-c", "rm -f /opt/mastodon/tmp/pids/server.pid; bundle exec rails s -p 3000"]
    environment = [{
        "name" : "ALTERNATE_IP_RANGES",
        "value" : join(",", [for s in data.aws_subnet.subnet : s.cidr_block])
    }]
    user = "mastodon"

}
*/