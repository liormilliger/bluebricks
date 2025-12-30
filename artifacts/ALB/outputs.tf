output "alb_security_group_id" {
  description = "The ID of the ALB Security Group (to allow traffic TO the EC2s)"
  value       = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  description = "The ARN of the Target Group (for the ASG to attach to)"
  value       = aws_lb_target_group.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Load Balancer (Customer Entry Point)"
  value       = aws_lb.this.dns_name
}
