# ==========================================
# 1. Terraform Configuration and Provider Requirements
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This is the gatekeeper or "prerequisites" block. It tells your computer:
#   - You must be running a modern version of Terraform (v1.7 or newer).
#   - You need to download the official Azure plugin (azurerm) from HashiCorp.
#   - It locks the version to 4.x so you automatically get minor security patches, 
#     but prevents a major upgrade to 5.0 which might break your existing code.

terraform {
  required_version = ">= 1.7.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" 
    }
  }
}


# ==========================================
# 2. Default Azure Provider
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This is the fallback, catch-all connector. If you write code to build a resource 
# (like a storage account) and forget to say exactly which subscription it belongs to, 
# Terraform will default to this block. It will deploy the resource straight into 
# whichever Azure subscription your terminal window is currently logged into via `az login`.

provider "azurerm" {
  features {}
}


# ==========================================
# 3. Aliased Provider for Management
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This creates a dedicated, custom pipeline specifically targeting your Management subscription. 
# By adding the nickname `alias = "management"`, you can tag resources in your main code 
# to force them into your central logging and monitoring subscription, completely bypassing 
# whatever account your terminal session is active in.

provider "azurerm" {
  alias           = "management"
  subscription_id = var.subscription_id_management
  features {}
}


# ==========================================
# 4. Aliased Provider for Connectivity
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This creates a dedicated pipeline specifically targeting your Networking subscription. 
# Whenever you build routers, firewalls, or core VNets, you tag them with `provider = azurerm.connectivity` 
# so Terraform knows to route those specific resources straight into this subscription.

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = var.subscription_id_connectivity
  features {}
}


# ==========================================
# 5. Aliased Provider for Identity
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This creates a dedicated pipeline specifically targeting your Security and Login subscription. 
# Any resources dealing with domain controllers, user authentication, or centralized identity 
# servers get tagged with `provider = azurerm.identity` to ensure they land securely in this bucket.

provider "azurerm" {
  alias           = "identity"
  subscription_id = var.subscription_id_identity
  features {}
}
