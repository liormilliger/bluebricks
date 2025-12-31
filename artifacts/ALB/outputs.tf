output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "public_subnets" {
  description = "The subnets selected for the ALB"
  value       = local.selected_subnets
}

output "private_subnets" {
  description = "The subnets selected for the RDS"
  value       = local.selected_subnets
}