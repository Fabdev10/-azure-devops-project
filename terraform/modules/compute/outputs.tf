output "vm_id" {
  description = "ID of the Bastion VM"
  value       = azurerm_linux_virtual_machine.bastion_vm.id
}

output "vm_principal_id" {
  description = "Principal ID of the System Assigned Managed Identity for the VM"
  value       = azurerm_linux_virtual_machine.bastion_vm.identity[0].principal_id
}
