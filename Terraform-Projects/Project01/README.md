```markdown
# ☁️ Azure Multi-Region Landing Zone & Core Networking (IaC)

A modular **Infrastructure as Code (IaC)** project deploying a zero-cost foundational landing zone on **Microsoft Azure** using **Terraform**. 

This deployment provisions isolated multi-region resource groups, non-overlapping virtual networks, custom subnet tiering, and decoupled Network Security Groups (NSGs).

---

## 📐 Architecture Topology

```text
Azure Subscription
│
├── 📍 South Central US [portfolio-landing-zone-rg-1]
│   └── 🌐 Virtual Network: portfolio-vnet-1 (10.0.0.0/16)
│       └── 🔹 Subnet: web-tier-subnet (10.0.1.0/24)
│            ├── 🔒 Associated NSG: portfolio-nsg
│            └── 🚫 Security Rule: DenyInternetInbound (Priority 100)
│
└── 📍 East US [testing-resource-group]
    └── 🌐 Virtual Network: portfolio-vnet-2 (10.1.0.0/16)

```

---

## 🚀 Core Infrastructure Components

* **Multi-Region Resource Isolation:** Configures different Resource Groups across `southcentralus` and `eastus` to simulate multi-environment segmentation.
* **Non-Overlapping CIDR Strategy:** Allocates `10.0.0.0/16` and `10.1.0.0/16` spaces to ensure future VNet peering compatibility without address collisions.
* **Granular Web-Tier Subnetting:** Isolates a `/24` subnet (`10.0.1.0/24`) ready for compute/workload hosting.
* **Decoupled Security Management:** Implements `azurerm_network_security_rule` as a modular component to easily manage, update or remove individual NSG rules without affecting the main NSG block. 
* **Explicit Subnet Association:** Links the NSG rules to the corresponding subnet that I want to protect `azurerm_subnet_network_security_group_association`.
* **Zero Compute Cost Architecture:** Created basic networking practice without incurring charges. 

---

## 🛠️ Tech Stack & Provider Config

| Technology / Tool | Version / Spec | Purpose |
| --- | --- | --- |
| **Terraform** | `>= 1.0` | Declarative Infrastructure as Code (IaC) engine |
| **AzureRM Provider** | `~> 3.0.2` | Azure Resource Manager (ARM) API interface |
| **Azure CLI** | Latest | Local authentication & deployment execution |
| **Target Cloud** | Microsoft Azure | Cloud hosting environment (`southcentralus`, `eastus`) |

---

## 💡 Key Engineering Takeaways

* **Explicit Security Associations:** Creating an Azure NSG does not automatically filter traffic until it is explicitly bound to a subnet using an association block.
* **Decoupled Security Rules:** Extracting rules into standalone resources requires explicit mapping to both `resource_group_name` and `network_security_group_name`.
* **Dynamic Dependency Graphs:** Referencing parent resource attributes (e.g., `azurerm_resource_group.my_1st_rg.location`) allows Terraform to automatically infer resource creation order.
* **Plan Verification:** Running `terraform plan` is essential to catch syntax errors, reference drift, and attribute mismatches before executing changes in the cloud.

---

## 📋 Quickstart Deployment

### Prerequisites

* Azure CLI installed and logged in (`az login`)
* Terraform installed locally

### Execution Steps

1. **Initialize Terraform & Providers:**
```bash
terraform init

```


2. **Generate & Inspect Deployment Plan:**
```bash
terraform plan -out=tfplan

```


3. **Deploy Infrastructure:**
```bash
terraform apply tfplan

```


4. **Tear Down Resources:**
```bash
terraform destroy -auto-approve

```



```

```
