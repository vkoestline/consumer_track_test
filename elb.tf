# --------------------------------------
# ELB for Nginx
# --------------------------------------
resource "aws_elb" "nginx" {
  name            = "nginx-lb"
  security_groups = ["${aws_security_group.elb_security_group.id}"]
  availability_zones = ["${data.aws_availability_zones.available.names}"]

  listener {
    instance_port     = 80
    instance_protocol = "TCP"
    lb_port           = 80
    lb_protocol       = "TCP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  idle_timeout = 1
}



