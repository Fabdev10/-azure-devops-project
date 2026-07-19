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

# ---------------------------------------------------------------------------
# IAM Outputs
# ---------------------------------------------------------------------------
output "iam_custom_role_id" {
  description = "L'ID della Custom Role creata"
  value       = module.iam.custom_role_id
}

output "iam_custom_role_name" {
  description = "Il nome della Custom Role creata"
  value       = module.iam.custom_role_name
}

output "iam_application_client_id" {
  description = "Il Client ID dell'Azure AD Application"
  value       = module.iam.application_client_id
}

output "iam_service_principal_client_id" {
  description = "Il Client ID del Service Principal"
  value       = module.iam.service_principal_client_id
}

output "iam_service_principal_object_id" {
  description = "L'Object ID del Service Principal"
  value       = module.iam.service_principal_object_id
}

# ---------------------------------------------------------------------------
# Fase 6 – ACR Outputs
# ---------------------------------------------------------------------------
output "acr_login_server" {
  description = "Login server dell'Azure Container Registry"
  value       = module.acr.acr_login_server
}

output "acr_id" {
  description = "ID ARM dell'Azure Container Registry"
  value       = module.acr.acr_id
}

# ---------------------------------------------------------------------------
# Fase 6 – AKS Outputs
# ---------------------------------------------------------------------------
output "aks_cluster_name" {
  description = "Nome del cluster AKS"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "ID ARM del cluster AKS"
  value       = module.aks.cluster_id
}

output "aks_oidc_issuer_url" {
  description = "URL OIDC issuer del cluster AKS — necessario per Workload Identity"
  value       = module.aks.oidc_issuer_url
}

output "aks_kubelet_identity_object_id" {
  description = "Object ID della kubelet managed identity"
  value       = module.aks.kubelet_identity_object_id
}

output "aks_cluster_fqdn" {
  description = "FQDN privato dell'API server AKS"
  value       = module.aks.cluster_fqdn
}

output "aks_kube_config_raw" {
  description = "Kubeconfig grezzo del cluster AKS (sensitive)"
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "networking_aks_subnet_id" {
  description = "ID della subnet AKS"
  value       = module.networking.aks_subnet_id
}

output "networking_nat_gateway_public_ip" {
  description = "IP pubblico del NAT Gateway usato dai nodi AKS"
  value       = module.networking.nat_gateway_public_ip
}
