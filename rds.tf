
resource "aws_db_instance" "my_test_mysql" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.6"
  instance_class              = "db.t2.micro"
  name                        = "myrdstestmysql"
  username                    = "admin"
  password                    = "admin1234"
  parameter_group_name        = "${aws_db_parameter_group.db_parameter_group.name}"
  db_subnet_group_name        = "${aws_db_subnet_group.db_subnet_group.name}"
  vpc_security_group_ids      = ["${aws_security_group.rds-sg.id}"]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  multi_az                    = false
  skip_final_snapshot         = true
}


resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = ["${aws_subnet.My_VPC_PrivateSubnet1.id}", "${aws_subnet.My_VPC_PrivateSubnet2.id}"]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "rds-pg"
  family = "mysql5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}


resource "aws_security_group" "rds-sg" {
  name = "terraform-example-rds"
  vpc_id      = aws_vpc.My_VPC.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}