variable "project" {
  description = "Nome del progetto"
  type        = string
}

variable "environment" {
  description = "Ambiente (es. dev, prod)"
  type        = string
}

variable "location" {
  description = "Regione Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nome del resource group"
  type        = string
}

variable "vnet_id" {
  description = "ID della VNet per il Private DNS Link"
  type        = string
}

variable "subnet_id" {
  description = "ID della subnet data per PostgreSQL"
  type        = string
}

variable "admin_login" {
  description = "Login dell'amministratore del database"
  type        = string

  validation {
    condition     = !contains(["azure_superuser", "admin", "administrator", "root", "guest", "public", "azuresu"], lower(var.admin_login))
    error_message = "admin_login non può essere un nome riservato da Azure PostgreSQL Flexible Server."
  }
}

variable "admin_password" {
  description = "Password dell'amministratore del database"
  type        = string
  sensitive   = true
}

variable "db_version" {
  description = "Versione di PostgreSQL"
  type        = string
  default     = "16"
}

variable "sku_name" {
  description = "SKU del database"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Storage in MB per il database"
  type        = number
  default     = 32768
}

variable "tags" {
  description = "Tag da applicare alle risorse"
  type        = map(string)
  default     = {}
}
