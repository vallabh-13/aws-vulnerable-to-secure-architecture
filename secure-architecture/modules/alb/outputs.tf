output "alb_arn" {
  value = aws_lb.alb.arn
}

output "dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
