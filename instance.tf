resource "aws_eip" "default" {
  instance = "${aws_instance.example.id}"
  vpc      = true
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.region]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.My_VPC_PublicSubnet1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_ebs_volume" "ebsexample" {
  availability_zone = var.availabilityZone
  size              = 2
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebsexample.id}"
  instance_id = "${aws_instance.example.id}"
}