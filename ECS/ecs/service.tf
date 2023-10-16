# ecs/service.tf

# Create an ECS service
resource "aws_ecs_service" "selenium_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.selenium_cluster.id
  task_definition = aws_ecs_task_definition.selenium_task.arn
  launch_type     = "FARGATE"

  # Specify the network configuration (VPC and subnets)
  network_configuration {
    subnets = var.subnet_ids # Replace with your subnet IDs
  }

  # Optional: Configure autoscaling if needed
  # enable_ecs_managed_tags = true
  # deployment_maximum_percent = 200
  # deployment_minimum_healthy_percent = 100
  # desired_count = 2
}
