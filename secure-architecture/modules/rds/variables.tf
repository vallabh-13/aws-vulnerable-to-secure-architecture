variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for RDS subnet group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for RDS"
}

variable "db_username" {
  type        = string
  description = "Master username for RDS"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Master password for RDS"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for RDS"
}
