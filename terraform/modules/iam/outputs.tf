output "custom_role_id" {
  description = "L'ID della Custom Role creata"
  value       = azurerm_role_definition.blob_writer.role_definition_resource_id
}

output "custom_role_name" {
  description = "Il nome della Custom Role creata"
  value       = azurerm_role_definition.blob_writer.name
}

output "custom_role_scope" {
  description = "Lo scope della Custom Role"
  value       = azurerm_role_definition.blob_writer.scope
}

output "application_client_id" {
  description = "Il Client ID dell'Azure AD Application"
  value       = azuread_application.main.client_id
}

output "service_principal_client_id" {
  description = "Il Client ID del Service Principal"
  value       = azuread_service_principal.main.client_id
}

output "service_principal_object_id" {
  description = "L'Object ID del Service Principal"
  value       = azuread_service_principal.main.object_id
}
