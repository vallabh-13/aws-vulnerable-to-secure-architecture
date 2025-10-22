# Bastion EC2 instance in private subnet (with public IP)
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]

  tags = {
    Name = "secure-bastion"
  }
}
