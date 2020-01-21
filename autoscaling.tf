## Creating Launch Configuration
resource "aws_launch_configuration" "example" {
  image_id               = var.AMIS[var.region]
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.allow-ssh.id}"]
  key_name               = aws_key_pair.mykeypair.key_name
  lifecycle {
    create_before_destroy = true
  }
}


## Creating AutoScaling Group
resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  #availability_zones = ["us-east-1a","us-east-1a","us-east-1a"]
  vpc_zone_identifier = ["${aws_subnet.My_VPC_PublicSubnet1.id}",
                         "${aws_subnet.My_VPC_PublicSubnet2.id}",
                         "${aws_subnet.My_VPC_PublicSubnet2.id}"]
  min_size = 2
  max_size = 3
  health_check_type = "ELB"
  target_group_arns = ["${aws_lb_target_group.test.arn}"]
  #load_balancers = ["${aws_lb.test_load.name}"]
  #health_check_type = "ELB"
  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_attachment" "attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.example.id}"
  alb_target_group_arn   = "${aws_lb_target_group.test.arn}"
}