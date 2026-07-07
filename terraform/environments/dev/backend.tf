terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatefabiomazza001" # Da personalizzare prima del deploy (deve essere univoco globalmente)
    container_name       = "tfstate"
    key                  = "dev/networking/terraform.tfstate"
  }
}
