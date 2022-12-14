
resource "aws_ecs_service" "puma" {

  # (Required) Name of the service (up to 255 letters, numbers, hyphens, and underscores)
  name = "${local.prefix}_puma"

  # (Optional) Capacity provider strategies to use for the service. Can be one or more. 
  # These can be updated without destroying and recreating the service only if force_new_deployment = true and
  # not changing from 0 capacity_provider_strategy blocks to greater than 0, or vice versa. See below.
  capacity_provider_strategy {
    base              = 1
    capacity_provider = "FARGATE"
    weight            = 100
  }

  # (Optional) ARN of an ECS cluster.
  cluster = aws_ecs_cluster.cluster.arn


  # (Optional) Configuration block for deployment circuit breaker.
  deployment_circuit_breaker {
    # (Required) Whether to enable the deployment circuit breaker logic for the service.
    enable = false

    # (Required) Whether to enable Amazon ECS to roll back the service if a service deployment fails. 
    # If rollback is enabled, when a service deployment fails, the service is rolled back 
    # to the last deployment that completed successfully.
    rollback = false
  }


  # (Optional) Configuration block for deployment controller configuration.
  deployment_controller {

    # (Optional) Type of deployment controller. Valid values: CODE_DEPLOY, ECS, EXTERNAL. Default: ECS.
    type = "ECS"
  }

  # (Optional) Upper limit (as a percentage of the service's desiredCount) of the number of 
  # running  tasks that can be running in a service during a deployment. 
  # Not valid when using the DAEMON scheduling strategy.
  deployment_maximum_percent = 200

  # (Optional) Lower limit (as a percentage of the service's desiredCount) of the number of 
  # running tasks that must remain running and healthy in a service during a deployment.
  deployment_minimum_healthy_percent = 100

  # (Optional) Number of instances of the task definition to place and keep running. Defaults to 0. 
  # Do not specify if using the DAEMON scheduling strategy.
  desired_count = 1

  # (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service.
  enable_ecs_managed_tags = false

  # (Optional) Specifies whether to enable Amazon ECS Exec for the tasks within the service.
  enable_execute_command = false

  # (Optional) Enable to force a new task deployment of the service.
  # This can be used to update tasks to use a newer Docker image with same image/tag combination 
  # (e.g., myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy
  # ordered_placement_strategy and placement_constraints updates.
  force_new_deployment = var.force_new_deployment

  # (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, 
  # up to 2147483647. Only valid for services configured to use load balancers.
  health_check_grace_period_seconds = 30

  # (Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. 
  # This parameter is required if you are using a load balancer with your service, but only if your task 
  # definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. 
  # If your account has already created the Amazon ECS service-linked role, that role is used by default for 
  # your service unless you specify a role here.
  iam_role = null # the task definition uses the awsvpc mode (Fargate)

  # (Optional) Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2.
  # launch_type = "FARGATE"

  # (Optional) Configuration block for load balancers. See below.
  load_balancer {
    # elb_name = # (Required for ELB Classic) Name of the ELB (Classic) to associate with the service.
    target_group_arn = var.puma_target_group_arn
    container_name   = "${local.prefix}_puma"
    container_port   = var.port_puma
  }

  # (Optional) Network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode 
  # to receive their own Elastic Network Interface, and it is not supported for other network modes.
  network_configuration {

    #  (Required) Subnets associated with the task or service.
    subnets = var.subnet_ids

    # (Optional) Security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
    security_groups = [aws_security_group.puma_sg.id]

    # (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false.
    assign_public_ip = true
  }

  # (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. 
  # Updates to this configuration will take effect next task deployment unless force_new_deployment is enabled. The maximum number of 
  # ordered_placement_strategy blocks is 5.
  # ordered_placement_strategy { }

  # (Optional) Rules that are taken into consideration during task placement. Updates to this configuration will take effect next task deployment 
  # unless force_new_deployment is enabled. Maximum number of placement_constraints is 10.
  # placement_constraints { }

  # (Optional) Platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST. 
  # More information about Fargate platform versions can be found in the AWS ECS User Guide.
  platform_version = "1.4.0"

  # (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION.
  propagate_tags = "SERVICE"

  # (Optional) Scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA. 
  # Note that Tasks using the Fargate launch type or the CODE_DEPLOY or EXTERNAL deployment controller types don't support the DAEMON scheduling strategy.
  scheduling_strategy = "REPLICA"

  # (Optional) The ECS Service Connect configuration for this service to discover and connect to services, 
  # and be discovered by, and connected from, other services within a namespace. See below.
  # service_connect_configuration { ... }

  # (Optional) Service discovery registries for the service. The maximum number of service_registries blocks is 1. See below.
  # service_registries { ... }

  # (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present,
  # tags with matching keys will overwrite those defined at the provider-level.
  # tags {...}

  # (Optional) Family and revision (family:revision) or full ARN of the task definition that you want to run in your service. 
  # Required unless using the EXTERNAL deployment controller. If a revision is not specified, the latest ACTIVE revision is used.
  task_definition = aws_ecs_task_definition.puma.arn

  # (Optional) Map of arbitrary keys and values that, when changed, will trigger an in-place update (redeployment). Useful with timestamp(). See example above.
  # triggers = null

  # (Optional) If true, Terraform will wait for the service to reach a steady state (like aws ecs wait services-stable) before continuing. Default false.
  wait_for_steady_state = false

}

