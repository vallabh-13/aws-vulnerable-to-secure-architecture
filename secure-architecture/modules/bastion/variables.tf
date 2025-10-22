variable "ami_id" {
  type        = string
  description = "AMI ID for Bastion host"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for Bastion host"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for Bastion host"
}

variable "key_name" {
  type        = string
  description = "SSH key name for Bastion host"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for Bastion host"
}
