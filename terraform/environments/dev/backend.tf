terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatedevopsops123" # Da personalizzare prima del deploy (deve essere univoco globalmente)
    container_name       = "tfstate-dev"
    key                  = "terraform.tfstate"
  }
}
