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

variable "storage_account_id" {
  type        = string
  description = "ID ARM dello Storage Account per definire lo scope della Custom Role e della Role Assignment"
}

variable "managed_identity_principal_id" {
  type        = string
  description = "Principal ID della Managed Identity a cui assegnare il ruolo Storage Blob Writer"
}

variable "tags" {
  type        = map(string)
  description = "Tag comuni da applicare a tutte le risorse del modulo"
  default     = {}
}
