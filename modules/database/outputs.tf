output "db_endpoint" {
  description = "The connection endpoint (address:port) of the RDS instance"
  value       = aws_db_instance.default.endpoint
}