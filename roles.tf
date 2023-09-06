
# CREATING IAM ROLE
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# ATTACHING CLOUDWATCH_FULL_ACCESS POLICY
resource "aws_iam_policy_attachment" "cloudwatch_full_access" {
  name = "cloudwatch-full-access"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING ECS_CONTAINER_SERVICE_ROLE POLICY
resource "aws_iam_policy_attachment" "ecs_container_service_role" {
  name = "ecs-container-service-role"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING ECS_CONTAINER_REGISTRY_FULL_ACCESS
resource "aws_iam_policy_attachment" "ecs_container_registry_full_access" {
  name = "ecs-container-registry-full-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING ECS_TASK_EXECUTION_ROLE POLICY
resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy" {
  name = "ecs-task-execution-role-policy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING SECRET_MANAGER_READ_WRITE POLICY
resource "aws_iam_policy_attachment" "secrets_manager_read_write" {
  name = "secrets-manager-read-write"
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING EC2_FULL_ACCESS POLICY
resource "aws_iam_policy_attachment" "ec2_full_access" {
  name = "ec2-full-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING RDS FULL ACCESS POLICY
resource "aws_iam_policy_attachment" "rds_full_access" {
  name = "rds-full-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

/*
# ATTACHING ECS FULL ACCESS POLICY
resource "aws_iam_policy_attachment" "ecs_full_access" {
  name = "ecs-full-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}
*/

# ATTACHING ECS ELASTIC CONTAINER REGISTRY PUBLIC FULL ACCESS POLICY
resource "aws_iam_policy_attachment" "ecs_elastic_container_registry_public_full_access" {
  name       = "ecs-elastic-container-registry-public-full-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicFullAccess"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

# ATTACHING AmazonEC2ContainerServiceforEC2Role POLICY
resource "aws_iam_policy_attachment" "ecs_ec2_container_service_role" {
  name       = "ecs-ec2-container-service-role"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}

/*
# ATTACHING THE POLICY THAT GRANTS ECR PERMISSIONS TO THE ECS TASK EXECUTION ROLE
resource "aws_iam_policy_attachment" "ecs_task_execution_ecr_policy" {
  name       = "ecs-task-execution-ecr-policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}
*/

# ATTACHING THE POLICY FOR API GATEWAY TO PUSH TO CLOUDWATCH LOGS
resource "aws_iam_policy_attachment" "ecs_task_execution_apigateway_logs_policy" {
  name       = "ecs-task-execution-apigateway-logs-policy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
}