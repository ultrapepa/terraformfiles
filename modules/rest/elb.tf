resource "aws_elb" "tutor_elb" {
  name = "tutor-elb"
  security_groups = [
    "sg-0607bbed2237e4453"
  ]
  subnets = [
    "subnet-07d4b41b72e4964be",
    "subnet-0016e94db7d3628fd"
  ]
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}
