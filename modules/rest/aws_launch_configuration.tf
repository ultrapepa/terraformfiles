resource "aws_launch_configuration" "tutor" {
  name_prefix                 = "tutor-"
  image_id                    = "ami-0c40c60965441fdad"
  instance_type               = "t2.micro"
  key_name                    = "keypairputty"
  security_groups             = ["sg-0607bbed2237e4453"]
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}
