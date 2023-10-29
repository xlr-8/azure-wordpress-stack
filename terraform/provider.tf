terraform {
  required_version = ">= 1.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.35.0, <4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}
