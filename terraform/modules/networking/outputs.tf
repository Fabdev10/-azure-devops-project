output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the created resource group"
}

output "resource_group_location" {
  value       = azurerm_resource_group.rg.location
  description = "The location of the created resource group"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the Virtual Network"
}

output "compute_subnet_id" {
  value       = azurerm_subnet.compute.id
  description = "The ID of the compute subnet"
}

output "data_subnet_id" {
  value       = azurerm_subnet.data.id
  description = "The ID of the data subnet"
}

output "bastion_public_ip_address" {
  value       = azurerm_public_ip.bastion_pip.ip_address
  description = "The public IP address for the bastion/jump box"
}

output "bastion_public_ip_id" {
  value       = azurerm_public_ip.bastion_pip.id
  description = "The ID of the public IP for the bastion"
}
