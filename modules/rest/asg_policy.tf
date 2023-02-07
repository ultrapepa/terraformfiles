resource "aws_autoscaling_policy" "tutor_policy_up" {
  name                   = "tutor_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tutor.name
}
resource "aws_cloudwatch_metric_alarm" "tutor_cpu_alarm_up" {
  alarm_name          = "tutor_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.tutor.name}"
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = ["${aws_autoscaling_policy.tutor_policy_up.arn}"]
}
resource "aws_autoscaling_policy" "tutor_policy_down" {
  name                   = "tutor_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tutor.name
}
resource "aws_cloudwatch_metric_alarm" "tutor_cpu_alarm_down" {
  alarm_name          = "tutor_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.tutor.name}"
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = ["${aws_autoscaling_policy.tutor_policy_down.arn}"]
}
