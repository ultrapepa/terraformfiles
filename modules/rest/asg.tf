resource "aws_autoscaling_group" "tutor" {
  name             = "tutor-asg"
  min_size         = 1
  desired_capacity = 2
  max_size         = 5

  health_check_type = "ELB"
  load_balancers = [
    "${aws_elb.tutor_elb.id}"
  ]
  launch_configuration = aws_launch_configuration.tutor.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = [
    "subnet-07d4b41b72e4964be",
    "subnet-0016e94db7d3628fd"
  ]
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "tutorr"
    propagate_at_launch = true
  }
}
