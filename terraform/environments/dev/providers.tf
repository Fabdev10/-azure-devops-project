terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.40"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "58b0f835-1284-4f9b-a000-c619f67faf59"
}

provider "azuread" {
}
