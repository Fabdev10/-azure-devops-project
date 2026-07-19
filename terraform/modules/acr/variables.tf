variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Nome del Resource Group in cui creare l'ACR"
}

variable "tags" {
  type        = map(string)
  description = "Tags da applicare alle risorse"
  default     = {}
}
