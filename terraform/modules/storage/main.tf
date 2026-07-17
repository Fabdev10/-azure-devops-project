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

  # I nomi degli storage account devono essere globalmente unici, lowercase, 3-24 caratteri, solo alfanumerici
  storage_account_name = lower(replace("${var.project}${var.environment}stor${var.location}", "-", ""))
}

# ---------------------------------------------------------------------------
# Storage Account
# ---------------------------------------------------------------------------
resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  # Nessun accesso pubblico ai blob
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  network_rules {
    default_action             = "Deny"
    ip_rules                   = var.allowed_storage_ips
    virtual_network_subnet_ids = [var.compute_subnet_id]
    bypass                     = ["AzureServices"]
  }

  tags = local.common_tags
}

# ---------------------------------------------------------------------------
# Storage Containers
# ---------------------------------------------------------------------------
resource "azurerm_storage_container" "uploads" {
  name                  = "uploads"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "backups" {
  name                  = "backups"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# ---------------------------------------------------------------------------
# Lifecycle Management Policy
# ---------------------------------------------------------------------------
resource "azurerm_storage_management_policy" "main" {
  storage_account_id = azurerm_storage_account.main.id

  rule {
    name    = "lifecycle-blob-tiering-and-deletion"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        # Muovi in Cool dopo 1 giorno dall'ultima modifica
        tier_to_cool_after_days_since_modification_greater_than = 1
        # Elimina il blob dopo 7 giorni dall'ultima modifica
        delete_after_days_since_modification_greater_than = 7
      }

      version {
        # Elimina le versioni precedenti dopo 3 giorni
        delete_after_days_since_creation = 3
      }
    }
  }
}

