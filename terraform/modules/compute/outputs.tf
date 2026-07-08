output "vm_id" {
  value = azurerm_linux_virtual_machine.bastion_vm.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.bastion_nic.private_ip_address
}

output "managed_identity_principal_id" {
  description = "Principal ID della System Assigned Identity, servirà per le role assignment IAM"
  value       = azurerm_linux_virtual_machine.bastion_vm.identity[0].principal_id
}
