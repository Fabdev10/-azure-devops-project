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
# Azure Container Registry
# SKU Basic (economico per dev), admin_enabled = false → accesso solo via
# managed identity / service principal, mai tramite credenziali statiche.
# ---------------------------------------------------------------------------
resource "azurerm_container_registry" "acr" {
  # I nomi ACR devono essere globalmente univoci, solo alfanumerici, 5-50 char.
  name                = "${replace(local.prefix, "-", "")}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false

  tags = local.common_tags
}
