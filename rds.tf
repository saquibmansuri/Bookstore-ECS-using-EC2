
/*
# CREATING SUBNET GROUP FOR RDS INSTANCE
resource "aws_db_subnet_group" "bookstore_subnet_grp" {
  name       = "bookstore"
  subnet_ids = [aws_subnet.bookstore_subnet1.id, aws_subnet.bookstore_subnet2.id]

  tags = {
    Name = "DB Subnet Group"
  }
}

# CREATING RDS (POSTGRESQL)
resource "aws_db_instance" "database_instance" {
  allocated_storage     = var.allocated_storage
  storage_type          = "${var.storage_type}"
  engine                = "${var.engine}"
  engine_version        = "${var.engine_version}"
  instance_class        = "${var.instance_class}"
  identifier            = "${var.identifier}"
  db_name               = "${var.db_name}"
  username              = "${var.username}"
  password              = "${var.password}"
  parameter_group_name  = "${var.parameter_group_name}"
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.bookstore_sg.id]  
  db_subnet_group_name  = aws_db_subnet_group.bookstore_subnet_grp.name
  publicly_accessible   = true
  backup_retention_period = var.backup_retention_period # This is to avoid taking backup when database is deleted
}
*/