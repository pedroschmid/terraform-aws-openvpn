resource "aws_instance" "openvpn" {
  ami           = var.EC2_AMI
  instance_type = "t2.micro"

  subnet_id       = aws_subnet.openvpn.id
  security_groups = [aws_security_group.openvpn.id]

  key_name = aws_key_pair.openvpn.key_name

  user_data = <<EOF
    admin_user=openvpn
    admin_pw=openvpn
  EOF

  tags = {
    "Name" = "openvpn-instance"
  }
}