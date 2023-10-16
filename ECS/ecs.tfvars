# ecs.tfvars

# Define values for variables
aws_region       = "ap-south-1"
ecs_cluster_name = "selenium-test-10"
iam_role_name    = "selenium-ecs-task-role-10"
iam_policy_arn   = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Adjust policy as needed
docker_image_url = "manojdevopseng/seleniumtestscript:latest"
container_port   = 80 # Replace with the port your script uses
host_port        = 80
subnet_ids       = ["subnet-04dec101c6314a975", "subnet-04320366ee3ba320b"] # Replace with your subnet IDs
ecs_service_name = "selenium-service-10"
