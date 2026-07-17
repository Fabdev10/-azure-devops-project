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
  description = "Nome del Resource Group in cui creare il cluster AKS"
}

variable "subnet_id" {
  type        = string
  description = "ID della subnet in cui deployare i nodi AKS (aks-subnet)"
}

variable "acr_id" {
  type        = string
  description = "ID ARM dell'Azure Container Registry a cui i nodi devono accedere"
}

variable "tags" {
  type        = map(string)
  description = "Tags da applicare alle risorse"
  default     = {}
}
