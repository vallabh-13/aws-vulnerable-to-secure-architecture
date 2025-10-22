output "alb_dns_name" {
  value = module.alb.dns_name
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}
