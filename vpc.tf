
# CREATING VPC
resource "aws_vpc" "bookstore_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Bookstore-VPC"
  }
}

# CREATING FIRST PUBLIC SUBNET
resource "aws_subnet" "bookstore_subnet1" {
  vpc_id                  = aws_vpc.bookstore_vpc.id
  cidr_block              = "${var.subnet1_cidr_block}"
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
  tags = {
    Name = "Bookstore-Subnet1"
  }
}

# CREATING SECOND PUBLIC SUBNET
resource "aws_subnet" "bookstore_subnet2" {
  vpc_id                  = aws_vpc.bookstore_vpc.id
  cidr_block              = "${var.subnet2_cidr_block}"
  availability_zone       = var.availability_zone2 
  map_public_ip_on_launch = true
  tags = {
    Name = "Bookstore-Subnet2"
  }
}

# CREATING INTERNET GATEWAY
resource "aws_internet_gateway" "bookstore_igw" {
  vpc_id = aws_vpc.bookstore_vpc.id
}

# CREATING ROUTE TABLE
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.bookstore_vpc.id
}

# ADDING ROUTE FOR SUBNET1 TO INTERNET GATEWAY
resource "aws_route" "public_subnet1_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.bookstore_igw.id
}

# ADDING ROUTE FOR SUBNET2 TO INTERNET GATEWAY
resource "aws_route" "public_subnet2_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.bookstore_igw.id
}

# ATTACHING ROUTE TABLE TO SUBNET1
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.bookstore_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

# ATTACHING ROUTE TABLE TO SUBNET2
resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.bookstore_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

