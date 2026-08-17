```markdown
# ☁️ Azure Landing Zone & Network Infrastructure (IaC)

## **Terraform Portfolio Project**

### **Project Overview**

This project demonstrates the design and deployment of multi-region foundational cloud infrastructure on **Microsoft Azure** using **Terraform (Infrastructure as Code)**. The implementation provisions core networking and security components—including resource groups, virtual networks (VNets), a web-tier subnet, and decoupled network security rules—while establishing cross-resource referencing and explicit subnet associations.

To prioritize cost optimization and resource hygiene during development, the landing zone was architected to incur **$0 in compute costs** by focusing strictly on the virtual networking and security plane before deploying workloads.

---

### **Architecture & Resource Topology**

```text
Azure Subscription
 ├── Resource Group 1: [portfolio-landing-zone-rg-1] (South Central US)
 │    ├── Virtual Network: [portfolio-vnet-1] (10.0.0.0/16)
 │    │    └── Subnet: [web-tier-subnet] (10.0.1.0/24)
 │    │         └── NSG Association ──┐
 │    └── Network Security Group (NSG): [portfolio-nsg] ◄──┘
 │         └── Rule: [DenyInternetInbound] (Priority 100 | Deny * from Internet)
 │
 └── Resource Group 2: [testing-resource-group] (East US)
      └── Virtual Network: [portfolio-vnet-2] (10.1.0.0/16)

```

---

### **Key Technical Components**

* **Multi-Region Resource Isolation:** Deploys independent resource groups across `southcentralus` and `eastus` to model environment separation.
* **Non-Overlapping CIDR Architecture:** Configures discrete address spaces (`10.0.0.0/16` and `10.1.0.0/16`) to maintain future peering compatibility without IP collisions.
* **Granular Subnet Slicing:** Provisions a `/24` web-tier subnet (`10.0.1.0/24`) inside the primary landing zone.
* **Decoupled Security Rules:** Defines the `DenyInternetInbound` rule (Priority 100) as a standalone `azurerm_network_security_rule` resource rather than an inline block, enabling modular rule management.
* **Explicit Subnet Association:** Binds the floating Network Security Group directly to the subnet using `azurerm_subnet_network_security_group_association`.

---

### **Engineering Takeaways & Lessons Learned**

* **Decoupled Security Management:** Managing network security rules as independent resources requires explicit upstream references to both the parent `resource_group_name` and `network_security_group_name`.
* **Explicit Subnet Attachment:** In Azure, creating an NSG does not automatically filter traffic. An explicit association resource (`azurerm_subnet_network_security_group_association`) is required to bind security controls to target subnets.
* **Dynamic Resource Referencing:** Utilizing Terraform interpolation attributes (`azurerm_resource_group.my_1st_rg.location`, `.name`, and `.id`) ensures deterministic resource ordering and clean dependency graphs.
* **IDE Sync & Code Hygiene:** CodeLens references and autocomplete assist with navigation, but automated testing via `terraform validate` and `terraform plan` remains essential to verify syntax and prevent naming drift.

---

### **Tools & Technologies**

| Tool / Resource | Purpose |
| --- | --- |
| **Terraform (HCL)** | Infrastructure as Code (IaC) declarative resource provisioning. |
| **Azure Provider (`azurerm`)** | Interfacing with the Azure Resource Manager (ARM) API. |
| **Azure CLI (`az`)** | Local authentication and execution context. |
| **GitHub** | Source control, versioning, and documentation. |

---

### **Deployment Instructions**

1. **Authenticate to Azure:**
```bash
az login

```


2. **Initialize Terraform:**
```bash
terraform init

```


3. **Validate & Plan Configuration:**
```bash
terraform plan -out=tfplan

```


4. **Apply Infrastructure:**
```bash
terraform apply tfplan

```


5. **Clean Up / Destroy Resources:**
```bash
terraform destroy

```



```

```
