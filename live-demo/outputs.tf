output "website_url" {
  description = "Access your scalable application here"
  value       = "http://${module.network.alb_dns_name}"
}

output "database_endpoint" {
  description = "The RDS Endpoint (internal only)"
  value       = module.database.db_endpoint
}
