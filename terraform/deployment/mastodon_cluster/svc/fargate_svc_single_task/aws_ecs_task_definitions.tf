resource "aws_ecs_task_definition" "task" {

  # (Required) A unique name for your task definition.
  family = "${local.prefix}_${var.simple_name}"

  # (Optional) Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required.
  cpu = var.cpu

  # (Optional) ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume.
  execution_role_arn = aws_iam_role.task_execution_role.arn

  # (Optional) Configuration block(s) with Inference Accelerators settings. Detailed below.
  # inference_accelerator = null

  # (Optional) IPC resource namespace to be used for the containers in the task The valid values are host, task, and none.  
  # ipc_mode = null # Not supported with Fargate

  # (Optional) Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required.
  memory = var.mem

  # (Optional) Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host.
  network_mode = "awsvpc"

  # (Optional) Configuration block for runtime_platform that containers in your task may use.  
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  # (Optional) Process namespace to use for the containers in the task. The valid values are host and task.
  # pid_mode = null # not supported with Fargate

  # (Optional) Configuration block for rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. Detailed below.
  # placement_constraints = # not supported for Fargate

  # (Optional) Set of launch types required by the task. The valid values are EC2, FARGATE, and EXTERNAL
  requires_compatibilities = ["FARGATE"]

  # (Optional) Whether to retain the old revision when the resource is destroyed or replacement is necessary. Default is false.
  skip_destroy = false

  # (Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.
  # tags = null  # use default_tags

  # (Optional) ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services.
  # task_role_arn = null    # update if containers need additional permissions

  # (Optional) Configuration block for volumes that containers in your task may use.
  # volume { ... } 

  # (Required) A list of valid container definitions provided as a single valid JSON document.
  # Please note that you should only provide values that are part of the container definition document.
  container_definitions = jsonencode([
    {
      name = "${local.prefix}_${var.simple_name}"

      image = "${var.ecr_image_url}:latest"

      # memory (not set)

      # memoryReservation (not set)

      portMappings = var.container_port == null ? null : [{
        appProtocol   = null
        containerPort = var.container_port
        hostPort      = null
        name          = null
        protocol      = "tcp"
      }]

      healthCheck = var.container_port == null ? null : {
        command     = var.health_check_command
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 30
      }

      # cpu = null  # Set at task-level above
      # gpu = null
      essential = true
      # entryPoint = null
      command          = var.run_command
      workingDirectory = var.working_directory
      # environmentFiles = null
      environment = var.environment

      # secrets = null

      /* <NotSupportedByFargate> */
      /*
      disableNetworking = false
      links = null
      hostname = null
      dnsServers = null
      dnsSearchDomains = null
      extraHosts = [{
        hostname = null
        ipAddress = null
      }]
      */
      /* </NotSupportedByFargate> */

      # readonlyRootFilesystem = false
      # mountPoints = null
      # volumesFrom = null

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group"  = "true"
          "awslogs-region"        = local.region
          "awslogs-group"         = "${local.prefix}_${var.simple_name}"
          "awslogs-stream-prefix" = "${local.prefix}_${var.simple_name}"
          "mode"                  = "non-blocking"
          "max-buffer-size"       = "2m"
        }
        # secretOptions = null
      }

      # options = null
      # firelensConfiguration = null

      # privileged = (not supported by Fargate)
      user = var.user
      # dockerSecurityOptions = ( not supported by Fargate )
      ulimits = [{
        name      = "nofile"
        softLimit = 16384
        hardLimit = 32768
      }]
      # dockerLabels = null
      # capabilities = null # going with the default
      # dependsOn = null
      # systemControls = null
    }
  ])

}