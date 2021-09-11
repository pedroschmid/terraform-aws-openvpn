locals {
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "openvpn" {
  name        = "openvpn-sg"
  description = "Allows inbound traffic through openvpn instance"
  vpc_id      = aws_vpc.openvpn.id

  ingress {
    description = "SSH to openvpn"
    protocol    = "tcp"
    from_port   = "22"
    to_port     = "22"
    cidr_blocks = local.cidr_blocks
  }

  ingress {
    description = "HTTPS"
    protocol    = "tcp"
    from_port   = "443"
    to_port     = "443"
    cidr_blocks = local.cidr_blocks
  }

  ingress {
    description = "Admin openvpn"
    protocol    = "tcp"
    from_port   = "943"
    to_port     = "943"
    cidr_blocks = local.cidr_blocks
  }

  ingress {
    description = "Public openvpn"
    protocol    = "tcp"
    from_port   = "945"
    to_port     = "945"
    cidr_blocks = local.cidr_blocks
  }

  ingress {
    description = "UDP openvpn"
    protocol    = "udp"
    from_port   = "1194"
    to_port     = "1194"
    cidr_blocks = local.cidr_blocks
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = local.cidr_blocks
  }
}