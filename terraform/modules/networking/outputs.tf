output "resource_group_name" {
  description = "Nome del Resource Group creato"
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "ID della Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Nome della Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "compute_subnet_id" {
  description = "ID della subnet compute, usata dalla VM bastion e dai futuri nodi AKS"
  value       = azurerm_subnet.compute.id
}

output "data_subnet_id" {
  description = "ID della subnet data, usata da PostgreSQL"
  value       = azurerm_subnet.data.id
}

output "compute_nsg_id" {
  description = "ID del Network Security Group della subnet compute"
  value       = azurerm_network_security_group.compute_nsg.id
}

output "data_nsg_id" {
  description = "ID del Network Security Group della subnet data"
  value       = azurerm_network_security_group.data_nsg.id
}

output "bastion_public_ip_id" {
  description = "ID dell'IP pubblico riservato per la VM bastion"
  value       = azurerm_public_ip.bastion_pip.id
}
