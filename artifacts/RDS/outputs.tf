output "db_endpoint" {
  description = "The connection endpoint for the database"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "The port the database is listening on"
  value       = aws_db_instance.this.port
}

output "connection_string" {
  description = "Full connection string (for debugging)"
  value       = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.this.address}:${aws_db_instance.this.port}/${var.db_name}"
  sensitive   = true
}
