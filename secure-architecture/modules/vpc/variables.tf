variable "cidr_block" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "your_ip" {
  type = string
  description = "Your public IP for SSH access to Bastion"
}

variable "alb_sg_id" {
  type = string
  description = "Security group ID of ALB to allow traffic to EC2"
}
