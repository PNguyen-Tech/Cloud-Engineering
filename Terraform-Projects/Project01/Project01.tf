#==============================================================================
# AZURE Project #1 Summary
# Version:     1.2
# Author:      Peter N. 
# Description: This is my first practice project and its main purpose is to create a resource group named "portfolio-landing-zone-rg" in the South Central US region,
#    along with a virtual network, subnet, and network security group (NSG) using Terraform. This code divides into 5 easy to read sections and gives me a better understanding
#    of resource references and dependency. 
#    No VMs will be created yet because I want to minimize cost to $0. 
# ==============================================================================


# What I Learned: Core Terraform & IDE Concepts
#1. IDE References & Smart Navigation
#The Concept: When editing a resource name in VS Code, features like CodeLens references or definition popups can show where that resource is used throughout the project.
# The Reality: This tool is great for navigation, but it doesn't automatically fix or sync your code everywhere if you rename something. Because autofill and tracking features can occasionally be inconsistent, manual code reviews or running a terraform plan are essential to catch mismatched names and syntax errors.

#2. Security Decoupling & Explicit Routing
#The Concept: A network security rule can be extracted from the main Network Security Group (NSG) block and managed as its own separate entity.
# The Reality: Moving a rule out on its own means you must explicitly tell it which Resource Group and NSG container it belongs to using tracking arguments inside the block.

#3. Subnet Association Controls
#The Concept: Creating an NSG doesn't mean it is automatically protecting your network traffic.
# The Reality: Once an NSG is built, you must use an explicit association block (azurerm_subnet_network_security_group_association) to physically link that security barrier to the correct subnet. This becomes critical as infrastructure scales to include multiple subnets or virtual networks across different regions.

# ==============================================================================
# AZURE PROVIDER CONFIGURATION
# 
# Purpose: Connects Terraform to the Azure API.
# Auth:    Uses your local Azure CLI credentials (run 'az login' first).
# Note:    The 'features' block is required by HashiCorp. Update the 'version' 
#          string periodically to access newer Azure resources.
# ==============================================================================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  features {}
}

# 2a. Create a Resource Group
resource "azurerm_resource_group" "my_1st_rg" {
  name     = "portfolio-landing-zone-rg-1" #Name of the resource group
  location = "southcentralus" #Location of where this resource group will be created. Choose a region close to you or your users for better performance.
  tags = {
    Environment = "learning" #tag key 
    Project     = "portfolio #1" #tag value
  }
}

# 2b. Create a second Resource Group
resource "azurerm_resource_group" "my_2nd_rg" {
  name     = "testing-resource-group" #Name of the resource group
  location = "eastus" #Location of where this resource group will be created. Choose a region close to you or your users for better performance.
  tags = {
    Environment = "learning" #tag key 
    Project     = "portfolio #2" #tag value
  }
}

# 3a. Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "portfolio-vnet-1" #Name of the virtual network
  address_space       = ["10.0.0.0/16"] #Private IP address range for the virtual network. This range can be adjusted based on your needs, but it should not overlap with any existing networks you plan to connect to.
  location            = azurerm_resource_group.my_1st_rg.location #This refers to the same location as the resource group. 
  resource_group_name = azurerm_resource_group.my_1st_rg.name #This refers to the same resource group name to organize the resources. 
  tags = {
    Environment = "learning" #tag key 
    Project     = "portfolio #1" #tag value
  }
}

# 3b. Create a Second Virtual Network
resource "azurerm_virtual_network" "vnet2" {
  name                = "portfolio-vnet-2" #Name of the virtual network
  address_space       = ["10.1.0.0/16"] #Private IP address range for the virtual network. This range can be adjusted based on your needs, but it should not overlap with any existing networks you plan to connect to.
  location            = azurerm_resource_group.my_2nd_rg.location #This will go to the eastus location
  resource_group_name = azurerm_resource_group.my_2nd_rg.name #This will go to the eastus location
  tags = {
    Environment = "learning" #tag key 
    Project     = "portfolio #1" #tag value
  }
}

# 4. Create a Subnet
resource "azurerm_subnet" "subnet-01" {
  name                 = "web-tier-subnet" #Name of the subnet
  resource_group_name  = azurerm_resource_group.my_1st_rg.name #azurerm_resounce_group is always the same. It references to "my_1st_rg" 
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 5. Create a Network Security Group (NSG) that will attach to the subnet. 
resource "azurerm_network_security_group" "nsg-01" {
  name                = "portfolio-nsg"
  location            = azurerm_resource_group.my_1st_rg.location #This refers to the same location as the resource group.
  resource_group_name = azurerm_resource_group.my_1st_rg.name
  tags = {
    Environment = "learning" #tag key
    Project     = "portfolio #1" #tag value
  }
}

# 6. Security Rule: Deny all inbound traffic from the Internet. 
resource "azurerm_network_security_rule" "deny_internet_inbound_katsu" { #This is the name of the security rule. It can be anything but should be unique within the NSG.
  resource_group_name         = azurerm_resource_group.my_1st_rg.name
  network_security_group_name = azurerm_network_security_group.nsg-01.name

    name                         = "DenyInternetInbound"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Deny"
    protocol                     = "*"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefix        = "Internet"
    destination_address_prefix   = "*"
  }


# 7. Associate the NSG to the Subnet
# Purpose: Links the floating NSG container directly to your subnet.
resource "azurerm_subnet_network_security_group_association" "web_tier_assoc" {
  subnet_id                 = azurerm_subnet.subnet-01.id
  network_security_group_id = azurerm_network_security_group.nsg-01.id
}
