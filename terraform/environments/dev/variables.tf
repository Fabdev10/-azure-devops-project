variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network"
}

variable "compute_subnet_prefix" {
  type        = string
  description = "Address prefix for the compute/AKS subnet"
}

variable "data_subnet_prefix" {
  type        = string
  description = "Address prefix for the data/private endpoint subnet"
}

variable "allowed_ssh_ips" {
  type        = list(string)
  description = "List of IP addresses allowed to connect via SSH"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "Public SSH key for the admin user of the Bastion VM"
}

variable "tags" {
  description = "Tag comuni per le risorse"
  type        = map(string)
  default     = {}
}

variable "db_admin_login" {
  description = "Login dell'amministratore del database"
  type        = string
}

variable "db_admin_password" {
  description = "Password dell'amministratore del database"
  type        = string
  sensitive   = true
}

variable "db_version" {
  description = "Versione di PostgreSQL"
  type        = string
  default     = "16"
}

variable "db_sku_name" {
  description = "SKU del database"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "db_storage_mb" {
  description = "Storage in MB per il database"
  type        = number
  default     = 32768
}

variable "allowed_storage_ips" {
  type        = list(string)
  description = "Lista di IP pubblici autorizzati ad accedere allo Storage Account"
  default     = []
}
