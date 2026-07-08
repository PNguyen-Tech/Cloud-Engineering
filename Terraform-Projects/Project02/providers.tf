#Core requirement and ensures that Terraform runs on version 1.7.

terraform {
  required_version = ">= 1.7.0" #Early 2024 release date

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" #Allows any patch/update within the v4.x line, but do not upgrade to 5.0 
          #"No matter what subscription my terminal is currently logged into, I want this specific provider block to target only the subscription ID stored in the subscription_id_management variable."
    }
  }
}

provider "azurerm" {
  features {}
}

#Version Pinning is enabled on this
#~> is a minor pinning
# = Strict Lockdown pin
# >= (Minimum Version Constraint): Tells Terraform, "Any version from 1.7.0 all the way up to 2.0 or 10.0 is fine, just nothing older than 1.7.0."
