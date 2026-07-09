# ==========================================
# 1. Katsu Corp Management Group Structure
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This block creates the folder structure (Management Groups) in the Azure Portal.
# It sets up the root "Katsu Corp" group and creates the "Platform" and "Landing Zones" folders
# underneath it, exactly like the tree diagram we built for GitHub.

resource "azurerm_management_group" "katsu_root" {
  display_name = var.root_name
  name         = var.root_id
}

resource "azurerm_management_group" "platform" {
  display_name               = "Platform"
  name                       = "${var.root_id}-platform"
  parent_management_group_id = azurerm_management_group.katsu_root.id
}

resource "azurerm_management_group" "landing_zones" {
  display_name               = "Landing Zones"
  name                       = "${var.root_id}-landing-zones"
  parent_management_group_id = azurerm_management_group.katsu_root.id
}


# ==========================================
# 2. Assigning Subscriptions to Management Groups
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This takes the 5 subscription IDs from your variables file and physically 
# moves them into their correct folders in the hierarchy tree.

resource "azurerm_management_group_subscription_association" "mgmt_assoc" {
  management_group_id = azurerm_management_group.platform.id
  subscription_id     = var.subscription_id_katsu_management
}

resource "azurerm_management_group_subscription_association" "connectivity_assoc" {
  management_group_id = azurerm_management_group.platform.id
  subscription_id     = var.subscription_id_katsu_connectivity
}

resource "azurerm_management_group_subscription_association" "identity_assoc" {
  management_group_id = azurerm_management_group.platform.id
  subscription_id     = var.subscription_id_katsu_identity
}


# ==========================================
# 3. Deploying Core Infrastructure to Subscriptions
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This is where you actually build resources. Notice the "provider" line inside each block!
# It explicitly tells Terraform which pipeline to take so the hub network lands in the 
# Connectivity subscription, and the central logs land in the Management subscription.

# A Resource Group created inside the Katsu Management Subscription
resource "azurerm_resource_group" "logging_rg" {
  provider = azurerm.katsu_management # <-- Routes this to the Management subscription
  name     = "rg-katsu-logging-prod"
  location = "southcentralus"
}

# A Core Network Hub created inside the Katsu Connectivity Subscription
resource "azurerm_virtual_network" "hub_vnet" {
  provider            = azurerm.katsu_connectivity # <-- Routes this to the Connectivity subscription
  name                = "vnet-katsu-hub-prod"
  resource_group_name = "rg-katsu-networking-prod" # Note: This RG would also need to be created using the connectivity provider
  address_space       = ["10.0.0.0/16"]
  location            = "southcentralus"
}
