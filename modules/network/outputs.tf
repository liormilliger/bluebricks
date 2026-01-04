output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "A list of IDs for the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "A list of IDs for the private subnets"
  value       = aws_subnet.private[*].id
}

output "shared_sg_id" {
  description = "The ID of the shared Security Group used by ALB, EC2, and RDS"
  value       = aws_security_group.shared.id
}