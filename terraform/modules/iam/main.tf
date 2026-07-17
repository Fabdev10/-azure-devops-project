terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
  }
}

locals {
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
# Custom Role Definition
# ---------------------------------------------------------------------------
resource "azurerm_role_definition" "blob_writer" {
  name        = "${var.project}-${var.environment}-Storage-Blob-Writer"
  scope       = var.storage_account_id
  description = "Allows reading, writing and creating blobs. Does not allow deletion."

  permissions {
    actions = []
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
    ]
    not_actions      = []
    not_data_actions = []
  }

  assignable_scopes = [
    var.storage_account_id
  ]
}

# ---------------------------------------------------------------------------
# Role Assignment per Managed Identity della VM
# ---------------------------------------------------------------------------
resource "azurerm_role_assignment" "vm_blob_writer" {
  scope              = var.storage_account_id
  role_definition_id = azurerm_role_definition.blob_writer.role_definition_resource_id
  principal_id       = var.managed_identity_principal_id
}

# ---------------------------------------------------------------------------
# Azure AD Application & Service Principal
# ---------------------------------------------------------------------------
resource "azuread_application" "main" {
  display_name = "${var.project}-${var.environment}-app"
  owners       = []
}

resource "azuread_service_principal" "main" {
  client_id = azuread_application.main.client_id
  owners    = []
}
