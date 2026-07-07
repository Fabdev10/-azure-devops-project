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

output "compute_nsg_id" {
  value = module.networking.compute_nsg_id
}

output "bastion_public_ip_id" {
  value = module.networking.bastion_public_ip_id
}

output "bastion_vm_id" {
  value = module.compute.vm_id
}

output "bastion_vm_principal_id" {
  value = module.compute.vm_principal_id
}
