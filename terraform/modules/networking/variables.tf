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
  description = "List of IP addresses allowed to connect via SSH"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
