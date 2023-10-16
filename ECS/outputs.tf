# outputs.tf

# Define any outputs here
output "ecs_service_name" {
  description = "Name of the ECS service for Selenium"
  value       = aws_ecs_service.selenium_service.name
}
