variable "project" {
  type        = string
  description = "Nome del progetto, usato nel prefisso dei nomi delle risorse"
}

variable "environment" {
  type        = string
  description = "Nome dell'ambiente (dev, staging, prod)"
}

variable "location" {
  type        = string
  description = "Azure region in cui deployare le risorse"
}

variable "resource_group_name" {
  type        = string
  description = "Nome del Resource Group in cui creare le risorse"
}

variable "allowed_storage_ips" {
  type        = list(string)
  description = "Lista di IP pubblici autorizzati ad accedere allo storage account (CIDR o indirizzi singoli)"

  validation {
    condition     = length(var.allowed_storage_ips) > 0
    error_message = "allowed_storage_ips non può essere vuota: specifica almeno un IP/CIDR autorizzato."
  }
}



variable "compute_subnet_id" {
  type        = string
  description = "ID della subnet compute, autorizzata ad accedere allo storage account via Service Endpoint"
}

variable "tags" {
  type        = map(string)
  description = "Tag comuni da applicare a tutte le risorse del modulo"
  default     = {}
}
