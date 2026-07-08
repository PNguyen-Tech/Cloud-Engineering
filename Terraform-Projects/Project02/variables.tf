variable "root_id" {
  type        = string
  description = "The ID used for the root management group and prefixing resources."
}

variable "root_name" {
  type        = string
  description = "The display name for the root management group."
}

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

variable "subscription_id_workloads_corp" {
  type        = string
  description = "Subscription ID for internal corporate applications (private IPs only)."
}

variable "subscription_id_workloads_online" {
  type        = string
  description = "Subscription ID for public-facing internet applications."
}
