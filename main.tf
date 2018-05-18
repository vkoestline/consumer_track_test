# --------------------------------------
# setup AWS 
# --------------------------------------
provider "aws" {
  region = "${var.region}"
}

# --------------------------------------
# Load Index File
# --------------------------------------
data "template_file" "index_file" {
  template = "${file("${path.module}/index.html")}"
}


# --------------------------------------
# Parameterize Nginx Index File in User Data Script
# --------------------------------------
data "template_file" "user_data_nginx_server" {
  template = "${file("${path.module}/user_data_nginx.sh")}"

  vars {
    index_file = "${data.template_file.index_file.rendered}" 
  }
}

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
  load_balancers       = ["${aws_elb.nginx.name}"]
  vpc_zone_identifier  = ["${module.networking.private_subnets}"]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_launch_configuration.nginx_server"]

  tags = [
    {
      key                 = "Name"
      value               = "Nginx"
      propagate_at_launch = "true"
    },
  ]
}


output "nginx_domain" {
  value = "${aws_elb.nginx.dns_name}"
}
