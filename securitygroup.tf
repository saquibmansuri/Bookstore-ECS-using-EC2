
# CREATING SECURITY GROUP
resource "aws_security_group" "bookstore_sg" {
  name_prefix = "SG-Bookstore"
  vpc_id     = aws_vpc.bookstore_vpc.id

  # ALLOWING ALL INCOMING TRAFFIC FOR NOW 
  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "${var.sg_protocol}"
    cidr_blocks = ["${var.sg_cidr_block}"]
  }

  # ALLOWING ALL OUTGOING TRAFFIC FOR NOW
  egress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "${var.sg_protocol}"
    cidr_blocks = ["${var.sg_cidr_block}"]
  }
}

