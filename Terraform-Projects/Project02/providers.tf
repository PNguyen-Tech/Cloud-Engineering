# ==========================================
# 1. Terraform Configuration and Provider Requirements
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This is the gatekeeper or "prerequisites" block. It tells your computer:
#   - You must be running a modern version of Terraform (v1.7 or newer).
#   - You need to download the official Azure plugin (azurerm) from HashiCorp.
#   - It locks the version to 4.x so you automatically get minor security patches, 
#     but prevents a major upgrade to 5.0 which might break your existing Katsu Corp code.

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
# This is the fallback, catch-all connector for Katsu Corp. If you write code to build a resource 
# (like a storage account) and forget to say exactly which subscription it belongs to, 
# Terraform will default to this block. It will deploy the resource straight into 
# whichever Azure subscription your terminal window is currently logged into via `az login`.

provider "azurerm" {
  features {}
}


# ==========================================
# 3. Aliased Provider for Katsu Management
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This creates a dedicated, custom pipeline specifically targeting your Katsu Management subscription. 
# By adding the nickname `alias = "katsu_management"`, you can tag resources in your main code 
# to force them into your central logging and monitoring subscription, completely bypassing 
# whatever account your terminal session is active in.

provider "azurerm" {
  alias           = "katsu_management"
  subscription_id = var.subscription_id_katsu_management
  features {}
}


# ==========================================
# 4. Aliased Provider for Katsu Connectivity
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This creates a dedicated pipeline specifically targeting your Katsu Networking subscription. 
# Whenever you build routers, firewalls, or core VNets, you tag them with `provider = azurerm.katsu_connectivity` 
# so Terraform knows to route those specific resources straight into this network hub.

provider "azurerm" {
  alias           = "katsu_connectivity"
  subscription_id = var.subscription_id_katsu_connectivity
  features {}
}


# ==========================================
# 5. Aliased Provider for Katsu Identity
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This creates a dedicated pipeline specifically targeting your Katsu Security and Login subscription. 
# Any resources dealing with domain controllers, user authentication, or centralized identity 
# servers get tagged with `provider = azurerm.katsu_identity` to ensure they land securely in this bucket.

provider "azurerm" {
  alias           = "katsu_identity"
  subscription_id = var.subscription_id_katsu_identity
  features {}
}
