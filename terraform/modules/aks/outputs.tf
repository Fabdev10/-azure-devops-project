output "cluster_id" {
  description = "ID ARM del cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  description = "Nome del cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "oidc_issuer_url" {
  description = "URL dell'OIDC issuer — necessario per configurare Workload Identity nei pod"
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "kubelet_identity_object_id" {
  description = "Object ID della kubelet managed identity — usato per role assignment su ACR e altri servizi"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "cluster_fqdn" {
  description = "FQDN privato dell'API server del cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.private_fqdn
}

output "kube_config_raw" {
  description = "Kubeconfig del cluster (sensibile)"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}
