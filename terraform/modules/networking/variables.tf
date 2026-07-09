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
  description = "Lista di IP CIDR autorizzati per SSH"

  validation {
    condition     = length(var.allowed_ssh_ips) > 0
    error_message = "allowed_ssh_ips non può essere vuota: specifica almeno un IP/CIDR autorizzato."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
