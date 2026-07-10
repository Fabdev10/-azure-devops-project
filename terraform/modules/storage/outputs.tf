output "storage_account_name" {
  description = "Nome dello Storage Account creato"
  value       = azurerm_storage_account.main.name
}

output "storage_account_id" {
  description = "ID ARM dello Storage Account"
  value       = azurerm_storage_account.main.id
}

output "uploads_container_name" {
  description = "Nome del container 'uploads'"
  value       = azurerm_storage_container.uploads.name
}

output "backups_container_name" {
  description = "Nome del container 'backups'"
  value       = azurerm_storage_container.backups.name
}
