# ecs/task.tf

# Create a task definition for your Selenium script
resource "aws_ecs_task_definition" "selenium_task" {
  family                   = "selenium-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_role.arn # Attach the task role

  # Specify the container details (replace with your Docker image)
  container_definitions = jsonencode([{
    name  = "selenium-container"
    image = var.docker_image_url # Replace with your Docker image URL
    portMappings = [{
      containerPort = var.container_port # Replace with the port your script uses
      hostPort      = var.host_port
    }]
  }])
}
