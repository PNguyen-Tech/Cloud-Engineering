terraform {
  required_version = ">= 1.7.0" #Early 2024 release date

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" #Allows any patch/update within the v4.x line, but do not upgrade to 5.0
    }
  }
}

provider "azurerm" {
  features {}
}

#Version Pinning is enabled on this
#~> is a minor pinning
# = Lockdown pin
# >= No Pinning 
