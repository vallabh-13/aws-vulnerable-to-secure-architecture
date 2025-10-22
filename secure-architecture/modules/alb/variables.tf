variable "vpc_id" {
  type        = string
  description = "VPC ID for ALB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for ALB"
}

variable "target_instance_id" {
  type        = string
  description = "EC2 instance ID to attach to target group"
}
