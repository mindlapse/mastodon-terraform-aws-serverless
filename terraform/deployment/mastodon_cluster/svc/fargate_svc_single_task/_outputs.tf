output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.svc.name
}