# variables.tf

# variables.tf

# Define input variables
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "selenium-cluster" # Set your desired default value
}

variable "iam_role_name" {
  description = "Name of the IAM role for ECS tasks"
  type        = string
  default     = "selenium-ecs-task-role" # Set your desired default value
}

variable "iam_policy_arn" {
  description = "IAM policy ARN to attach to the ECS task role"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Set your desired policy ARN
}

# Define input variables
variable "aws_region" {
  description = "AWS region for ECS resources"
  default     = "ap-south-1" # Replace with your desired region
}
