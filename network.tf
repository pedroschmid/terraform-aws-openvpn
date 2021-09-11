resource "aws_vpc" "openvpn" {
  cidr_block           = var.VPC_CIDR_BLOCK
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "openvpn-vpc"
  }
}

resource "aws_subnet" "openvpn" {
  cidr_block = var.PUBLIC_SUBNETS_CIDR[0]
  vpc_id     = aws_vpc.openvpn.id

  map_public_ip_on_launch = true

  tags = {
    "Name" = "openvpn-public-subnet"
  }
}

resource "aws_internet_gateway" "openvpn" {
  vpc_id = aws_vpc.openvpn.id
  
  tags = {
    "Name" = "openvpn-igw"
  }
}

resource "aws_route_table" "openvpn" {
  vpc_id = aws_vpc.openvpn.id

  tags = {
    "Name" = "openvpn-public-route-table"
  }
}

resource "aws_route" "openvpn" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.openvpn.id
  route_table_id = aws_route_table.openvpn.id
}

resource "aws_route_table_association" "openvpn" {
  subnet_id = aws_subnet.openvpn.id
  route_table_id = aws_route_table.openvpn.id
}