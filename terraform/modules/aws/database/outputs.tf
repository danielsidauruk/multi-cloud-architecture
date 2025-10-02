output "db_instance_address" {
  description = "Database Instance Address (Endpoint)."
  value = aws_db_instance.postgres_primary_instance.address
}

output "db_instance_port" {
  description = "Database Port."
  value       = aws_db_instance.postgres_primary_instance.port
}

output "db_name" {
  description = "The name of the database."
  value       = aws_db_instance.postgres_primary_instance.database_insights_mode
}