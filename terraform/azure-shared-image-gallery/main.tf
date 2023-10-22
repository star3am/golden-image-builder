terraform {
  required_version = "~> 1.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.57"
    }
  }
}

provider "azurerm" {
  # Default authentication is via ENV variables see: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal
  features {}
}
