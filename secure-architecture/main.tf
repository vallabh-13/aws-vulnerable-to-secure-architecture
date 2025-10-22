provider "aws" {
  region = "us-east-2"
}

# VPC with public/private subnets, route tables, IGW, NAT
module "vpc" {
  source                = "./modules/vpc"
  cidr_block            = "10.1.0.0/16"
  public_subnet_cidrs   = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs  = ["10.1.101.0/24", "10.1.102.0/24"]
  azs                   = ["us-east-2a", "us-east-2b"]
  your_ip               = "76.35.60.97/32"  # Replace with your actual IP
  alb_sg_id             = module.alb.alb_sg_id
}

# NAT Gateway for outbound traffic from private subnets
module "nat" {
  source               = "./modules/nat"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  private_subnet_ids   = module.vpc.private_subnet_ids
}

# Bastion Host for SSH access to private EC2
module "bastion" {
  source              = "./modules/bastion"
  subnet_id           = module.vpc.private_subnet_ids[0]
  key_name            = var.key_name
  ami_id              = var.ami_id
  security_group_id   = module.vpc.bastion_sg_id
}

# EC2 App Server (private subnet, no public IP)
module "ec2" {
  source              = "./modules/ec2"
  subnet_id           = module.vpc.private_subnet_ids[1]
  key_name            = var.key_name
  ami_id              = var.ami_id
  instance_type       = "t3.micro"
  security_group_id   = module.vpc.ec2_sg_id
}

# RDS (private subnet, locked-down SG)
module "rds" {
  source              = "./modules/rds"
  subnet_ids          = module.vpc.private_subnet_ids
  vpc_id              = module.vpc.vpc_id
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_id   = module.vpc.rds_sg_id
}

# ALB in public subnet, routing to EC2
module "alb" {
  source              = "./modules/alb"
  public_subnet_ids   = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  target_instance_id  = module.ec2.instance_id
}

# WAF ACL attached to ALB
module "waf" {
  source              = "./modules/waf"
  alb_arn             = module.alb.alb_arn
}

# VPC Endpoint for private S3 access
module "s3_endpoint" {
  source                  = "./modules/s3_endpoints"
  vpc_id                  = module.vpc.vpc_id
  region                  = var.region
  private_route_table_ids = [module.nat.private_route_table_id]
}


# Reference shared S3 bucket (already created)
module "s3" {
  source      = "./modules/s3"
  bucket_name = "secure-app-data-bucket"
}
