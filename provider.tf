terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "az-ccoedev-infra-automation"
    storage_account_name = "azsaccoedevtfstate"
    container_name       = "azblobccoedevtfstate"
    key                  = "az-ccoedev-infra-automation.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
