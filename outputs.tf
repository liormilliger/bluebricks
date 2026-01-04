output "alb_dns_name" {
  description = "The public DNS name of the Application Load Balancer"
  value       = module.compute.alb_dns_name
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS database instance"
  value       = module.database.db_endpoint
}

output "public_subnets_ids" {
    description = "The AWS id of the public subnets"
    value = module.network.public_subnet_ids
}