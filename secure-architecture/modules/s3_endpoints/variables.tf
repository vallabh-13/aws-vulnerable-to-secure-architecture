variable "vpc_id" {
  type        = string
  description = "VPC ID for the endpoint"
}

variable "region" {
  type        = string
  description = "AWS region for the endpoint"
}

variable "private_route_table_ids" {
  type        = list(string)
  description = "Route table IDs for private subnets"
}
