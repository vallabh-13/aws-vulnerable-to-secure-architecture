output "db_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "db_identifier" {
  value = aws_db_instance.rds.id
}
