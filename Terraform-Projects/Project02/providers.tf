# 1. Terraform Configuration and Provider Requirements
terraform {
  required_version = ">= 1.7.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Allows minor updates/patches (e.g., 4.1, 4.2), prevents major upgrades to 5.0
    }
  }
}

# 2. Default Azure Provider
# Automatically targets whatever subscription your terminal/CLI session is currently logged into.
provider "azurerm" {
  features {}
}

# 3. Aliased Provider for Management
# Targets the explicit subscription ID provided by the management variable.
provider "azurerm" {
  alias           = "management"
  subscription_id = var.subscription_id_management
  features {}
}

# 4. Aliased Provider for Connectivity
# Targets the explicit subscription ID provided by the connectivity variable.
provider "azurerm" {
  alias           = "connectivity"
  subscription_id = var.subscription_id_connectivity
  features {}
}

# 5. Aliased Provider for Identity
# Targets the explicit subscription ID provided by the identity variable.
provider "azurerm" {
  alias           = "identity"
  subscription_id = var.subscription_id_identity
  features {}
}
