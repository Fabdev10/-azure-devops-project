output "acr_id" {
  description = "ID ARM dell'Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "Login server dell'ACR (es. azdodevacr.azurecr.io)"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_name" {
  description = "Nome dell'ACR"
  value       = azurerm_container_registry.acr.name
}
