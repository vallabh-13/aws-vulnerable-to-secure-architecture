# Subnet group for RDS (private subnets only)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "secure-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "secure-rds-subnet-group"
  }
}

# RDS instance (MySQL example)
resource "aws_db_instance" "rds" {
  identifier              = "secure-rds-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [var.security_group_id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false

  tags = {
    Name = "secure-rds-db"
  }
}
