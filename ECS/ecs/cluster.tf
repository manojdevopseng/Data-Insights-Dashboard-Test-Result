# ecs/cluster.tf

# Create an ECS cluster
resource "aws_ecs_cluster" "selenium_cluster" {
  name = var.ecs_cluster_name
}
