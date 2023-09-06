
# THIS FILE CONTAINS VALUES OF ALL THE VARIABLES IN VARIABLES.TF FILE
# WE CAN EASILY CHANGE VALUES OF THE VARIABLES WE WANT


# THESE ARE VARIABLE VALUES FOR PROVIDER.TF FILE
#access_key = "${{ secrets.ACCESS_KEY }}"
#secret_key = "${{ secrets.SECRET_KEY }}"
region     = "us-east-1"



# THESE ARE VARIABLE VALUES FOR VPC
vpc_cidr_block     = "10.0.0.0/16"
subnet1_cidr_block = "10.0.1.0/24"
availability_zone1 = "us-east-1a"
subnet2_cidr_block = "10.0.2.0/24"
availability_zone2 = "us-east-1b"



# THESE ARE THE VARIABLES FOR SECURITY GROUP
from_port     = 0
to_port       = 0
sg_protocol   = "-1"
sg_cidr_block = "0.0.0.0/0"



# THESE ARE VARIABLE VALUES FOR LOAD BALANCER
certificate_arn = "arn:aws:acm:us-east-1:505660359349:certificate/f0dafe2a-49c1-4eed-a17a-7a76b94b3288"


# VARIABLES FOR RDS
allocated_storage = 20
storage_type      = "gp2"
engine            = "postgres"
engine_version    = "15.3"
instance_class    = "db.t3.micro"
identifier        = "database1"
db_name           = "database1"
username          = "postgres"
password          = "databaseuser"
parameter_group_name = "default.postgres15"
backup_retention_period = 0


# THESE ARE THE VARIABLES FOR EC2 LAUNCH TEMPLATE
instance_image_id = "ami-0f409bae3775dc8e5"
instance_type     = "t2.micro"
key_name          = "kp1"

# VARIABLE VALUES FOR AUTOSCALING GROUP
max_size         = 4
min_size         = 4
desired_capacity = 4

# VARIABLE VALUES FOR CAPACITY PROVIDER
maximum_scaling_step_size = 1
minimum_scaling_step_size = 1
target_capacity           = 4

