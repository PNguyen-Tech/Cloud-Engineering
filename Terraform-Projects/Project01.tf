#==============================================================================
# AZURE Project #1 Summary
# This is my first practice project and its main purpose is to create a resource group named "portfolio-landing-zone-rg" in the South Central US region,
# along with a virtual network, subnet, and network security group (NSG) using Terraform. This code divides into 5 easy to read sections and gives me a better understanding
# of resource references and dependency. 
# No VMs will be created yet because I want to minimize cost to $0. 
# ==============================================================================


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

# 2. Create a Resource Group
resource "azurerm_resource_group" "my_main_rg" {
  name     = "portfolio-landing-zone-rg" #Name of the resource group
  location = "southcentralus" #Location of where this resource group will be created. Choose a region close to you or your users for better performance.
  tags = {
    Environment = "learning" #tag key 
    Project     = "portfolio" #tag value
  }
}

# 3. Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "portfolio-vnet" #Name of the virtual network
  address_space       = ["10.0.0.0/16"] #Private IP address range for the virtual network. This range can be adjusted based on your needs, but it should not overlap with any existing networks you plan to connect to.
  location            = azurerm_resource_group.my_main_rg.location #This refers to the same location as the resource group. 
  resource_group_name = azurerm_resource_group.my_main_rg.name #This refers to the same resource group name to organize the resources. 
  tags = {
    Environment = "learning" #tag key 
    Project     = "portfolio" #tag value
  }
}

# 4. Create a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "web-tier-subnet" #Name of the subnet
  resource_group_name  = azurerm_resource_group.my_main_rg.name #azurerm_resource_group is always the same. It references to "my_main_rg" 
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 5. Create a Network Security Group (NSG) that will attach to the subnet. 
resource "azurerm_network_security_group" "nsg" {
  name                = "portfolio-nsg"
  location            = azurerm_resource_group.my_main_rg.location #This refers to the same location as the resource group.
  resource_group_name = azurerm_resource_group.my_main_rg.name
  tags = {
    Environment = "learning" #tag key
    Project     = "portfolio" #tag value
  }


# 6. Security Rule: Deny all inbound traffic from the Internet. This code is read with the NSG and is wrapped with Section #5
  security_rule {
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
}

# 7. Associate the NSG to the Subnet. So when the NSG is created, it is not linked with any resource. 
# This code is to link the NSG with the subnet. So when the NSG is created, it will be applied to the subnet 
# and all resources within that subnet.
resource "azurerm_subnet_network_security_group_association" "web_tier_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id #Points to the subnet created in step 4
  network_security_group_id = azurerm_network_security_group.nsg.id #Points to the NSG created in step 5
}
