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
  description = "List of Public Subnets (for ASG/Compute)"
  value       = data.aws_subnets.public.ids
}

output "private_subnets" {
  description = "List of Private Subnets (for RDS)"
  value       = data.aws_subnets.private.ids
}