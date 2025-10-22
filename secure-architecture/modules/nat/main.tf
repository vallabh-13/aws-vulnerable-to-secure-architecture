# Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {

  tags = {
    Name = "secure-nat-eip"
  }
}

# Create NAT Gateway in public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "secure-nat-gateway"
  }
}

# Private Route Table with NAT route
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "secure-private-rt"
  }
}

# Associate private subnets with private route table
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}
