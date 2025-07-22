terraform {
  required_version = ">= 1.12.1"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.37.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  }
