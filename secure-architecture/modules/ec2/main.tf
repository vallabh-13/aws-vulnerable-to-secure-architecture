# EC2 App Server in private subnet
resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]

  tags = {
    Name = "secure-app-server"
  }
}
