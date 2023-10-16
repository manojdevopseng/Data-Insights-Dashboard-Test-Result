# main.tf

# Configure the AWS provider
provider "aws" {
  region = var.aws_region
}

# Include the ECS module
module "ecs_selenium" {
  source = "./ecs"
}
