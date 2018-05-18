# --------------------------------------
# ELB security group
# --------------------------------------
resource "aws_security_group" "elb_security_group" {
  name        = "elb_security_group"
  description = "Allow TCP ports required for Web Access"
  vpc_id = "${module.networking.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --------------------------------------
# instance security group
# --------------------------------------
resource "aws_security_group" "nginx_server" {
  name        = "nginx_server"
  description = "Allow Access for Nginx Server"
  vpc_id = "${module.networking.vpc_id}"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.elb_security_group.id}"]
  }
}


