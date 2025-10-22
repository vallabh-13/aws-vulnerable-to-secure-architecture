variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 app server"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for EC2 app server"
}

variable "subnet_id" {
  type        = string
  description = "Private subnet ID for EC2"
}

variable "key_name" {
  type        = string
  description = "SSH key name for EC2"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for EC2"
}
