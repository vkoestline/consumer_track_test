# --------------------------------------
# Autoscaling Up Policy
# --------------------------------------
resource "aws_autoscaling_policy" "scale_up" {
  name = "nginx-host-scale-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.nginx_autoscaling_group.name}"
}

# --------------------------------------
# Autoscaling Down Policy
# --------------------------------------
resource "aws_autoscaling_policy" "scale_down" {
  name = "nginx-host-scale-down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.nginx_autoscaling_group.name}"
}

# --------------------------------------
# A CloudWatch alarm that monitors CPU utilization of cluster instances for scaling up
# --------------------------------------
resource "aws_cloudwatch_metric_alarm" "cluster_host_cpu_high" {
  alarm_name = "nginx-host-CPU-utilization-Above-80"
  alarm_description = "This alarm monitors NGINX host CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "80"
  alarm_actions = ["${aws_autoscaling_policy.scale_up.arn}"]

  dimensions {
    ClusterName = "${aws_autoscaling_group.nginx_autoscaling_group.name}"
  }
}

# --------------------------------------
# A CloudWatch alarm that monitors CPU utilization of cluster instances for scaling down
# --------------------------------------
resource "aws_cloudwatch_metric_alarm" "cluster_host_cpu_low" {
  alarm_name = "nginx-host-CPU-utilization-Below-10"
  alarm_description = "This alarm monitors NGINX host CPU utilization for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Minimum"
  threshold = "10"
  alarm_actions = ["${aws_autoscaling_policy.scale_down.arn}"]

  dimensions {
    ClusterName = "${aws_autoscaling_group.nginx_autoscaling_group.name}"
  }
}

