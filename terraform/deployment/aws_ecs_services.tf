
# resource "aws_ecs_service" "mastodon" {
#     name = "mastodon"
#     cluster = aws_ecs_cluster.cluster.arn

#     desired_count = 1

#     deployment_circuit_breaker {
#         enable = true
#         rollback = true
#     }

#     deployment_controller {
#       type = "ECS"
#     }

#     enable_ecs_managed_tags = true

#     enable_execute_command = true

#     force_new_deployment = false

#     health_check_grace_period_seconds = 60

#     launch_type = "FARGATE"

#     load_balancer = {
#         target_group_arn = 
#         container_name = "mastodon"
#         container_port = ""
#     }



# }
