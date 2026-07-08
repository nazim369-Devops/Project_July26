terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }

#   backend "azurerm" {
#     resource_group_name  = "rgforstate"
#     storage_account_name = "astorageforstate"
#     container_name       = "containerforstate"
#     key                  = "genericmodules.tfstate"
#   }
}

provider "azurerm" {
  features {}
}