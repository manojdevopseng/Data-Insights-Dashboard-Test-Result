# ecs/iam.tf

# Create an IAM role for ECS tasks
resource "aws_iam_role" "ecs_task_role" {
  name = var.iam_role_name

  # Assume role policy for ECS tasks
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach necessary IAM policies to the ECS task role
resource "aws_iam_policy_attachment" "ecs_task_policy" {
  iam_policy_arn = var.iam_policy_arn # Adjust policy as needed
  role       = aws_iam_role.ecs_task_role.name
}
