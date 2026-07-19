locals {
  prefix = "${var.project}-${var.environment}"
  common_tags = merge(
    var.tags,
    {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )
}

# ---------------------------------------------------------------------------
# AKS Cluster
# - private_cluster_enabled  → API server non esposto su Internet
# - identity SystemAssigned  → nessuna SP da ruotare manualmente
# - oidc_issuer_enabled      → prerequisito per Workload Identity
# - workload_identity_enabled→ permette ai pod di ricevere token Azure AD
# - network_plugin azure + overlay + policy azure → CNI moderno, scalabile
# ---------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.prefix}-aks-${var.location}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${local.prefix}-aks"

  private_cluster_enabled = true

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "system"
    vm_size        = "Standard_D2as_v7"
    vnet_subnet_id = var.subnet_id

    # Autoscaling: min 1, max 3 nodi
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    node_count          = 1

    os_disk_size_gb = 64
    os_disk_type    = "Managed"

    tags = local.common_tags
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    service_cidr   = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"

    outbound_type = "userAssignedNATGateway"
  }

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
    ]
  }
}

# ---------------------------------------------------------------------------
# Node Pool "User" separato dal pool di sistema
# - mode User → workload applicativi; il pool system resta riservato a
#   componenti Kubernetes di sistema (coredns, kube-proxy…)
# ---------------------------------------------------------------------------
# Node pool "user" rimosso temporaneamente: quota vCPU regionale esaurita
# su questa subscription (Free Trial) in italynorth. Da reintrodurre se si
# richiede un aumento di quota, o su una subscription diversa.
#resource "azurerm_kubernetes_cluster_node_pool" "user" {
#  name                  = "user"
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#  vm_size               = "Standard_D2as_v7"
#  vnet_subnet_id        = var.subnet_id
#  mode                  = "User"
#
#  # Autoscaling: min 1, max 2 nodi
#  enable_auto_scaling = true
#  min_count           = 1
#  max_count           = 2
#  node_count          = 1
#
#  os_disk_size_gb = 64
#  os_disk_type    = "Managed"
#
#  tags = local.common_tags
#
#  lifecycle {
#    ignore_changes = [node_count]
#  }
#}

# ---------------------------------------------------------------------------
# Role Assignment: AcrPull sulla kubelet identity
# Consente ai nodi di fare pull delle immagini dall'ACR senza credenziali
# statiche. Usa kubelet_identity[0].object_id perché è la managed identity
# associata ai nodi (diversa dalla cluster identity).
# ---------------------------------------------------------------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Role Assignment: consente alla Managed Identity della VM bastion di agire
# come utente del cluster AKS (utile per kubectl o integrazioni lato bastion).
resource "azurerm_role_assignment" "bastion_aks_user_role" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = var.managed_identity_principal_id
}
