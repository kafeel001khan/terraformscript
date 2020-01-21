# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.My_VPC_PublicSubnet1.id
  depends_on    = [aws_internet_gateway.My_VPC_GW]
}

# VPC setup for NAT
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.My_VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.My_VPC_PrivateSubnet1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = aws_subnet.My_VPC_PrivateSubnet2.id
  route_table_id = aws_route_table.main-private.id
}
