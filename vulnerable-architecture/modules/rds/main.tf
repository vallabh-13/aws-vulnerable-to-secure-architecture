resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "vulnerable-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "VulnerableRDSSubnetGroup"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "vulnerable-rds-sg"
  description = "Open RDS access (insecure)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "vulnerable-db"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = var.db_username
  password                = var.db_password
  allocated_storage       = 20
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = true
  skip_final_snapshot     = true
}
