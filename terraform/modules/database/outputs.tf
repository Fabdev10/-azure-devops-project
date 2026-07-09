output "server_id" {
  description = "L'ID del PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.postgres.id
}

output "server_fqdn" {
  description = "Il FQDN (Fully Qualified Domain Name) del PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "server_name" {
  description = "Il nome del PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.postgres.name
}
