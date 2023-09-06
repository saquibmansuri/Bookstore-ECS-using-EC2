
# CREATING LOAD BALANCER
resource "aws_lb" "bookstore_lb" {
  name               = "Bookstore-LB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.bookstore_subnet1.id, aws_subnet.bookstore_subnet2.id]
  enable_deletion_protection = false
  security_groups   = [aws_security_group.bookstore_sg.id]
}

# CREATING TARGET GROUP FOR DB_MIGRATOR
resource "aws_lb_target_group" "tg_db_migrator" {
  name     = "TG-DbMigrator"
  port     = 5432
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.bookstore_vpc.id
}

# CREATING TARGET GROUP FOR WEB
resource "aws_lb_target_group" "tg_web" {
  name     = "TG-Web"
  port     = 5002
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id   = aws_vpc.bookstore_vpc.id
}

# CREATING TARGET GROUP FOR HTTP_API_HOST
resource "aws_lb_target_group" "tg_http_api_host" {
  name     = "TG-HttpApiHost"
  port     = 5001
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id   = aws_vpc.bookstore_vpc.id
}

# CREATING TARGET GROUP FOR AUTH_SERVER
resource "aws_lb_target_group" "tg_auth_server" {
  name     = "TG-AuthServer"
  port     = 5003
  protocol = "HTTPS"
  target_type = "instance"
  vpc_id   = aws_vpc.bookstore_vpc.id
}


# CREATING LISTENER FOR WEB AND ATTACHING TARGET GROUP WEB
resource "aws_lb_listener" "listener_web" {
  load_balancer_arn = aws_lb.bookstore_lb.arn
  port              = 5002
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_web.arn
  }

  certificate_arn = "${var.certificate_arn}"
}

# CREATING LISTENER FOR HTTP_API HOST AND ATTACHING TARGET GROUP HTTP_API_HOST
resource "aws_lb_listener" "listener_http_api" {
  load_balancer_arn = aws_lb.bookstore_lb.arn
  port              = 5001
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_http_api_host.arn
  }

  certificate_arn = "${var.certificate_arn}"
}

# CREATING LISTENER FOR AUTH_SERVER AND ATTACHING TARGET GROUP AUTH_SERVER
resource "aws_lb_listener" "listener_auth_server" {
  load_balancer_arn = aws_lb.bookstore_lb.arn
  port              = 5003
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_auth_server.arn
  }

  certificate_arn = "${var.certificate_arn}"
}

# CREATING LISTENER DB-MIGRATOR AND ATTACHING TARGET GROUP DB_MIGRATOR
resource "aws_lb_listener" "listener_db_migrator" {
  load_balancer_arn = aws_lb.bookstore_lb.arn
  port              = 5432
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_db_migrator.arn
  }
}


