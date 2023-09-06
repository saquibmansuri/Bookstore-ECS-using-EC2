
# Creating CloudWatch Logs log groups for ECS tasks

# For DB Migrator
resource "aws_cloudwatch_log_group" "db_migrator_log_group" {
  name              = "/ecs/TD-DbMigrator"
  retention_in_days = 90 # Set the desired retention period in days
}

# For Web
resource "aws_cloudwatch_log_group" "web_log_group" {
  name              = "/ecs/TD-Web"
  retention_in_days = 90 # Set the desired retention period in days
}

# For HTTP API Host
resource "aws_cloudwatch_log_group" "http_api_host_log_group" {
  name              = "/ecs/TD-HttpApiHost"
  retention_in_days = 90 # Set the desired retention period in days
}

# For Auth Server
resource "aws_cloudwatch_log_group" "auth_server_log_group" {
  name              = "/ecs/TD-AuthServer"
  retention_in_days = 90 # Set the desired retention period in days
}




# CREATING TASK DEFINITION FOR DB MIGRATOR
resource "aws_ecs_task_definition" "td_db_migrator" {
  family                   = "TD-DbMigrator"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  memory                   = "1024"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
    
  container_definitions = jsonencode([
    {
      name  = "DbMigrator"
      image = "505660359349.dkr.ecr.us-east-1.amazonaws.com/bookstore-app:db-migrator-latest"
      cpu   = 1024
      memory= 1024
      portMappings = [
        {
          containerPort = 5432
          hostPort      = 5432
          protocol      = "tcp"
          application   = "http"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/TD-DbMigrator"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      
      }
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "us-east-1"
        },
        {
          name  = "RUNNING_ENVIRONMENT"
          value = "Prod"
        },
        # Add more environment variables as needed
      ]
    }
  ])
}


# CREATING TASK DEFINITION FOR WEB
resource "aws_ecs_task_definition" "td_web" {
  family                   = "TD-Web"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  memory                   = "1024"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  
  container_definitions = jsonencode([
    {
      name  = "Web"
      image = "505660359349.dkr.ecr.us-east-1.amazonaws.com/bookstore-app:web-latest"
      cpu   = 1024
      memory= 1024
      portMappings = [
        {
          containerPort = 443
          hostPort      = 5002  
          protocol      = "tcp"
          application   = "https"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/TD-Web"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "us-east-1"
        },
        {
          name  = "RUNNING_ENVIRONMENT"
          value = "Prod"
        },
        {
          name  = "ASPNETCORE_URLS"
          value = "https://+"
        },
        {
          name  = "ASPNETCORE_HTTPS_PORT"
          value = "5002"
        },
        {
          name  = "ASPNETCORE_Kestrel__Certificates__Default__Password"
          value = "P@ssw0rd"
        },
        {
          name  = "ASPNETCORE_Kestrel__Certificates__Default__Path"
          value = "/https/certificate.pfx"
        },
        # Add more environment variables as needed
      ]
    }
  ])
}


# CREATING TASK DEFINITION FOR HTTP_API_HOST
resource "aws_ecs_task_definition" "td_http_api_host" {
  family                   = "TD-HttpApiHost"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  memory                   = "1024"
  
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name  = "HttpApiHost"
      image = "505660359349.dkr.ecr.us-east-1.amazonaws.com/bookstore-app:http-api-host-latest"
      cpu   = 1024
      memory= 1024
      portMappings = [
        {
          containerPort = 443
          hostPort      = 5001  
          protocol      = "tcp"
          application   = "https"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/TD-HttpApiHost"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "us-east-1"
        },
        {
          name  = "RUNNING_ENVIRONMENT"
          value = "Prod"
        },
        {
          name  = "ASPNETCORE_URLS"
          value = "https://+"
        },
        {
          name  = "ASPNETCORE_HTTPS_PORT"
          value = "5001"
        },
        {
          name  = "ASPNETCORE_Kestrel__Certificates__Default__Password"
          value = "P@ssw0rd"
        },
        {
          name  = "ASPNETCORE_Kestrel__Certificates__Default__Path"
          value = "/https/certificate.pfx"
        },
        # Add more environment variables as needed
      ]
    }
  ])
}

# CREATING TASK DEFINITION FOR AUTH SERVER
resource "aws_ecs_task_definition" "td_auth_server" {
  family                   = "TD-AuthServer"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  memory                   = "1024"
  
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name  = "AuthServer"
      image = "505660359349.dkr.ecr.us-east-1.amazonaws.com/bookstore-app:authserver-latest"
      cpu   = 1024
      memory= 1024
      portMappings = [
        {
          containerPort = 443
          hostPort      = 5003  
          protocol      = "tcp"
          application   = "https"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/TD-AuthServer"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "us-east-1"
        },
        {
          name  = "RUNNING_ENVIRONMENT"
          value = "Prod"
        },
        {
          name  = "ASPNETCORE_URLS"
          value = "https://+"
        },
        {
          name  = "ASPNETCORE_HTTPS_PORT"
          value = "5003"
        },
        {
          name  = "ASPNETCORE_Kestrel__Certificates__Default__Password"
          value = "P@ssw0rd"
        },
        {
          name  = "ASPNETCORE_Kestrel__Certificates__Default__Path"
          value = "/https/certificate.pfx"
        },
        # Add more environment variables as needed
      ]
    }
  ])
}








# CREATING BOOKSTORE CLUSTER
resource "aws_ecs_cluster" "bookstore_cluster" {
  name = "Bookstore-Cluster"
}

/* # USED LAUNCH TEMPLATE INSTEAD OF LAUNCH CONFIGURATION, BECAUSE AWS IS STOPPING LAUNCH CONFIGURATION SOON

# CREATING LAUNCH CONFIGURATION
resource "aws_launch_configuration" "Bookstore-lc" {
  name_prefix   = "Bookstore-LC"
  image_id = "${var.instance_image_id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  key_name      = "kp1"
  security_groups = [aws_security_group.bookstore_sg.id]
  lifecycle {
    create_before_destroy = true
  }
}
*/


# CREATING LAUNCH TEMPLATE FOR AUTOSCALING GROUP
resource "aws_launch_template" "bookstore_lt" {
  name = "bookstore_lt"
  image_id = "${var.instance_image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  #vpc_security_group_ids = [aws_security_group.bookstore_sg.id]
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.bookstore_sg.id]
  }
}  



# CREATING AUTOSCALING GROUP
resource "aws_autoscaling_group" "bookstore_asg" {
  name = "Bookstore-ASG"
  #launch_configuration = aws_launch_configuration.Bookstore-lc.name
  launch_template {
    id     = aws_launch_template.bookstore_lt.id
  }
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  protect_from_scale_in = true
  vpc_zone_identifier = [
    aws_subnet.bookstore_subnet1.id,
    aws_subnet.bookstore_subnet2.id,
    # Add more subnet IDs if required
  ]

  target_group_arns = [
    aws_lb_target_group.tg_web.arn,
    aws_lb_target_group.tg_http_api_host.arn,
    aws_lb_target_group.tg_auth_server.arn,
    aws_lb_target_group.tg_db_migrator.arn
    # Add more target group ARNs here as needed
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# CREATING CAPACITY PROVIDER WITH THE AUTOSCALING GROUP
resource "aws_ecs_capacity_provider" "bookstore_capacity_provider" {
  name = "Bookstore-Capacity-Provider"
  #cluster_name = aws_ecs_cluster.bookstore_cluster.name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.bookstore_asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = var.maximum_scaling_step_size
      minimum_scaling_step_size = var.minimum_scaling_step_size
      status                    = "ENABLED"
      target_capacity           = var.target_capacity
    }
  }
}

# ATTACHING CAPACITY PROVIDER TO THE ECS CLUSTER
resource "aws_ecs_cluster_capacity_providers" "Bookstore-cp" {
  cluster_name = aws_ecs_cluster.bookstore_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.bookstore_capacity_provider.name]

}









# CREATING ECS SERVICE FOR DB MIGRATOR
resource "aws_ecs_service" "db_migrator_service" {
  name            = "DBMigratorService"
  cluster         = aws_ecs_cluster.bookstore_cluster.id
  task_definition = aws_ecs_task_definition.td_db_migrator.arn
  desired_count   = 1     # Desired tasks: 1

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bookstore_capacity_provider.name
    weight            = 1  # Adjust the weight as needed
    base              = 1  # Adjust the base as needed
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_db_migrator.arn
    container_name   = "DbMigrator"
    container_port   = 5432
  }
}


# CREATING SERVICE FOR WEB
resource "aws_ecs_service" "web_service" {
  name            = "WebService"
  cluster         = aws_ecs_cluster.bookstore_cluster.id
  task_definition = aws_ecs_task_definition.td_web.arn
  desired_count   = 1     # Desired tasks: 1

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bookstore_capacity_provider.name
    weight            = 1  # Adjust the weight as needed
    base              = 1  # Adjust the base as needed
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_web.arn
    container_name   = "Web"
    container_port   = 443
  }

  # Ensuring that the web_service depends on the db_migrator_service
  depends_on = [aws_ecs_service.db_migrator_service]
}


# CREATING SERVICE FOR HTTP API HOST
resource "aws_ecs_service" "http_api_host_service" {
  name            = "HttpApiHostService"
  cluster         = aws_ecs_cluster.bookstore_cluster.id
  task_definition = aws_ecs_task_definition.td_http_api_host.arn
  desired_count   = 1     # Desired tasks: 1

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bookstore_capacity_provider.name
    weight            = 1  # Adjust the weight as needed
    base              = 1  # Adjust the base as needed
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_http_api_host.arn
    container_name   = "HttpApiHost"
    container_port   = 443
  }

  # Ensure that the http_api_host_service depends on the db_migrator_service
  depends_on = [aws_ecs_service.db_migrator_service]
}


# CREATING SERVICE FOR AUTH SERVER
resource "aws_ecs_service" "auth_server_service" {
  name            = "AuthServerService"
  cluster         = aws_ecs_cluster.bookstore_cluster.id
  task_definition = aws_ecs_task_definition.td_auth_server.arn
  desired_count   = 1     # Desired tasks: 1

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bookstore_capacity_provider.name
    weight            = 1  # Adjust the weight as needed
    base              = 1  # Adjust the base as needed
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_auth_server.arn
    container_name   = "AuthServer"
    container_port   = 443
  }

  # Ensure that the auth_server_service depends on the db_migrator_service
  depends_on = [aws_ecs_service.db_migrator_service]
}