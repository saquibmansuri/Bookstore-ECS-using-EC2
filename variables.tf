
# THIS FILE CONTAINS ALL THE VARIABLE DECLARATIONS WHICH WILL BE USED 


# THESE ARE THE VARIABLES FOR PROVIDER.tf FILE
/*
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}
*/
variable "region" {
  type = string
}


# THESE ARE THE VARIABLES FOR VPC
variable "vpc_cidr_block" {
  type = string
}

variable "subnet1_cidr_block" {
  type = string
}

variable "availability_zone1" {
  type = string
}

variable "subnet2_cidr_block" {
  type = string
}

variable "availability_zone2" {
  type = string
}



# THESE ARE THE VARIABLES FOR SECURITY GROUP
variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "sg_protocol" {
  type = string
}

variable "sg_cidr_block" {
  type = string
}


# VARIABLES FOR LOAD BALANCER
variable "certificate_arn" {
  type = string
}


# VARIABLES FOR RDS
variable "allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "identifier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

variable "backup_retention_period" {
  type = number
}


# THESE ARE THE VARIABLES FOR EC2 LAUNCH TEMPLATE
variable "instance_image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}


# VARIABLES FOR AUTOSCALING GROUP
variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}


# VARIABLES FOR CAPACITY PROVIDER

variable "maximum_scaling_step_size" {
  type = number
}

variable "minimum_scaling_step_size" {
  type = number
}

variable "target_capacity" {
  type = number
}










