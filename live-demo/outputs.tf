output "website_url" {
  description = "Access your scalable application here"
  value       = "http://${module.network.alb_dns_name}"
}

output "database_endpoint" {
  description = "The RDS Endpoint (internal only)"
  value       = module.database.db_endpoint
}

output "public_subnet_ids" {
  description = "List of public subnets ids"
  value = module.network.public_subnets
}

output "private_subnet_ids" {
  description = "List of private subnets ids"
  value = module.network.private_subnets
}
