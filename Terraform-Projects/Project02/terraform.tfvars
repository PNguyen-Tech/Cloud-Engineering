# ==========================================
# 1. Katsu Corp Top-Level Branding
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This sets the actual values for your organization's naming scheme. 
# "katsu" will be used as the shorthand prefix for naming resources, 
# and "Katsu Corp Enterprise Infrastructure" is the official title.

root_id   = "katsu"
root_name = "Katsu Corp Enterprise Infrastructure"


# ==========================================
# 2. Platform Core Subscription IDs
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This is where you plug in the actual 36-character account numbers (GUIDs) 
# for Katsu Corp's foundational IT operations (Logging, Networking, and Security).

subscription_id_katsu_management   = "00000000-0000-0000-0000-000000000000"
subscription_id_katsu_connectivity = "11111111-1111-1111-1111-111111111111"
subscription_id_katsu_identity     = "22222222-2222-2222-2222-222222222222"


# ==========================================
# 3. Landing Zone Workload Subscription IDs
# ==========================================
# 📝 WHAT THIS DOES IN SIMPLE TERMS:
# This is where you plug in the actual account numbers for where Katsu Corp's 
# live internal apps (Corp) and public web apps (Online) will run.

subscription_id_katsu_workloads_corp   = "33333333-3333-3333-3333-333333333333"
subscription_id_katsu_workloads_online = "44444444-4444-4444-4444-444444444444"
