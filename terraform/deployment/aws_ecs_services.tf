
# resource "aws_ecs_service" "mastodon" {

#     name = "mastodon"

#     // capacity_provider_strategy (not overridden)

#     cluster = aws_ecs_cluster.cluster.arn

#     deployment_circuit_breaker {
#         enable = true
#         rollback = true
#     }

#     deployment_controller {
#       type = "ECS"
#     }

#     deployment_maximum_percent = 200

#     deployment_minimum_healthy_percent = 100

#     desired_count = 1
#     lifecycle {
#         ignore_changes = [desired_count]
#     }

#     enable_ecs_managed_tags = true

#     enable_execute_command = true

#     force_new_deployment = false

#     health_check_grace_period_seconds = 600

#     // iam_role (not specified - the Amazon ECS service-linked role is used by default)

#     launch_type = "FARGATE"

#     load_balancer = {
#         target_group_arn = module.fargate_alb.target_group_arn
#         container_name = "mastodon"
#         container_port = ""
#     }

#     network_configuration = {

#     }


# }
