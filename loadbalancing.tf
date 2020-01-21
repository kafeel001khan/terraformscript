resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.My_VPC.id}"
}


resource "aws_lb" "test_load" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.elb_sg.id}"]
  subnets            = ["${aws_subnet.My_VPC_PublicSubnet1.id}",
                        "${aws_subnet.My_VPC_PublicSubnet2.id}",
                        "${aws_subnet.My_VPC_PublicSubnet2.id}"]

  tags = {
    Environment = "production"
  }
}


## Security Group for ELB
resource "aws_security_group" "elb_sg" {
  name = "terraform-example-elb"
  vpc_id      = aws_vpc.My_VPC.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}