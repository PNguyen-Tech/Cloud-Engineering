# ==========================================
# 1. Root Enterprise Landing Zone Settings
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This section sets up the top-level naming conventions. 
# Think of "root_id" as a short nickname (like an acronym) used to prefix your resources, 
# and "root_name" as the official, friendly company name that shows up in the Azure Portal.

variable "root_id" {
  type        = string
  description = "The ID used for the root management group and prefixing resources."
  default     = "alz" 
}

variable "root_name" {
  type        = string
  description = "The display name for the root management group."
  default     = "Azure Landing Zones"
}


# ==========================================
# 2. Platform Core Subscription IDs
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This section holds the account numbers (IDs) for the shared backbone infrastructure.
# Instead of mixing everything together, we split the core IT operations into three dedicated buckets:
#   - Management: Where logs, alerts, and monitoring data are sent.
#   - Connectivity: Where the main network routers, firewalls, and DNS records live.
#   - Identity: Where security logins and domain controllers are kept.

variable "subscription_id_management" {
  type        = string
  description = "Subscription ID for central logging, monitoring, and management."
}

variable "subscription_id_connectivity" {
  type        = string
  description = "Subscription ID for hub networking, firewalls, and DNS zones."
}

variable "subscription_id_identity" {
  type        = string
  description = "Subscription ID for Active Directory domain controllers or identity services."
}


# ==========================================
# 3. Landing Zone Workload Subscription IDs
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This section holds the account numbers (IDs) for where the actual business applications live.
# To keep things secure, we split applications into two separate environments:
#   - Corp: For internal company tools that should never be exposed to the public internet.
#   - Online: For public-facing websites or mobile apps that customers need to access from anywhere.

variable "subscription_id_workloads_corp" {
  type        = string
  description = "Subscription ID for internal corporate applications (private IPs only)."
}

variable "subscription_id_workloads_online" {
  type        = string
  description = "Subscription ID for public-facing internet applications."
}
