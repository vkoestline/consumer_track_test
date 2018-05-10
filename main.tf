# --------------------------------------
# setup AWS 
# --------------------------------------
provider "aws" {
  region = "${var.region}"
}

# PUT A SECURITY GROUP IN HERE FOR WEB ACCESS


# --------------------------------------
# Load Index File
# --------------------------------------
data "template_file" "index_file" {
  template = "${file("${path.module}/index.html")}"
}


# --------------------------------------
# Parameterize Puppet Agent
# --------------------------------------
data "template_file" "user_data_nginx_server" {
  template = "${file("${path.module}/user_data_nginx.sh")}"

  vars {
    index_file = "${data.template_file.index_file.rendered}" 
  }
}



# --------------------------------------
# Get all AZs
# --------------------------------------
data "aws_availability_zones" "available" {}

# --------------------------------------
# Create Nginx Launch Configuration 
# --------------------------------------
resource "aws_launch_configuration" "nginx_server" {
  name_prefix     = "${var.unique_name}-nginx"
  instance_type   = "${var.instance_type}"
  image_id        = "${var.image_id}"
  #key_name        = "${var.key_name}"
  user_data       = "${data.template_file.user_data_nginx_server.rendered}"
  security_groups      = ["${aws_security_group.nginx_server.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

# --------------------------------------
# Create an AutoScaling Group
# --------------------------------------
resource "aws_autoscaling_group" "nginx_autoscaling_group" {
  name                 = "${aws_launch_configuration.nginx_server.name}-node"
  min_size             = "${var.min_nginx_servers}"
  max_size             = "${var.max_nginx_servers}"
  desired_capacity     = "${var.desired_nginx_servers}"
  launch_configuration = "${aws_launch_configuration.nginx_server.name}"
  availability_zones   = ["${data.aws_availability_zones.available.names}"]
  load_balancers       = ["${aws_elb.nginx.name}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_launch_configuration.nginx_server"]
}


output "nginx_domain" {
  value = "${aws_elb.nginx.dns_name}"
}
