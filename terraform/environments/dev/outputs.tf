output "resource_group_name" {
  value = module.networking.resource_group_name
}

output "vnet_id" {
  value = module.networking.vnet_id
}

output "compute_subnet_id" {
  value = module.networking.compute_subnet_id
}

output "data_subnet_id" {
  value = module.networking.data_subnet_id
}

output "compute_ssh_command" {
  description = "Comando per connettersi via SSH alla VM bastion"
  value       = "ssh ${var.admin_ssh_public_key != "" ? "azureuser" : "azureuser"}@${module.networking.bastion_public_ip_address}"
}

output "database_fqdn" {
  description = "Il FQDN (Fully Qualified Domain Name) del PostgreSQL Flexible Server"
  value       = module.database.server_fqdn
}

output "compute_nsg_id" {
  value = module.networking.compute_nsg_id
}

output "bastion_public_ip_id" {
  value = module.networking.bastion_public_ip_id
}

output "bastion_vm_id" {
  value = module.compute.vm_id
}

output "bastion_vm_private_ip" {
  value = module.compute.vm_private_ip
}

output "managed_identity_principal_id" {
  value = module.compute.managed_identity_principal_id
}

output "storage_account_name" {
  description = "Nome dello Storage Account creato nella Fase 4"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "ID ARM dello Storage Account"
  value       = module.storage.storage_account_id
}

output "uploads_container_name" {
  description = "Nome del container 'uploads'"
  value       = module.storage.uploads_container_name
}

output "backups_container_name" {
  description = "Nome del container 'backups'"
  value       = module.storage.backups_container_name
}
