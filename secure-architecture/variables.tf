variable "region" {
  type    = string
  default = "us-east-2"
}

variable "key_name" {
  type = string
  description = "Name of the EC2 key pair"
}

variable "ami_id" {
  type = string
  description = "AMI ID for EC2 and Bastion instances"
}

variable "db_username" {
  type = string
  description = "RDS master username"
}

variable "db_password" {
  type      = string
  sensitive = true
  description = "RDS master password"
}
