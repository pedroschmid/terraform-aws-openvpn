resource "tls_private_key" "openvpn" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = tls_private_key.openvpn.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.openvpn.private_key_pem}' > ./keys/openvpn.pem"
  }
}