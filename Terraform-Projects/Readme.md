# 🏗️ Terraform Infrastructure Portfolio

This is my central repository for Cloud Engineering and Infrastructure as Code (IaC) development. This repository serves as a portfolio of my work architecting, provisioning, and automating secure cloud environments exclusively using Terraform.

---

## 📂 Repository Architecture

This repository contains practice projects designed to explore the deployment of modern cloud infrastructure using Terraform. The directory is structured as follows:

```text
/
├── README.md                 # Portfolio overview and documentation
└── terraform/                # Infrastructure as Code deployments
    ├── project-01/           # Base networking and core infrastructure (Creating a resource group, VNet, Subnet, NSG and a security rule)
    ├── project-02/           # Building on Project #1, create multiple new resources and new dependencies. 
    ├── project-03/           # Identity, access management, and governance
    └── project-04/           # Secure key vaults and disk encryption

```

---

## 🛠️ Core Concepts Demonstrated

Across these projects, configurations are built to showcase adherence to enterprise-level infrastructure-as-code best practices, including:

* **Modular Architecture:** Designing reusable, highly parameterized modules to deploy scalable infrastructure across different environments.
* **State Management:** Configuring secure, remote backends to safely manage state tracking, resource locking, and collaboration.
* **Security & Perimeter Hardening:** Setting up strict Network Security Groups (NSGs), isolated subnets, and secure access vectors to protect data in transit and at rest.

## Terraform Code Reminder 
**terraform init**: downloads the required cloud provider plugins and sets up your working directory.    
**terraform plan**: previews a secure dry run of exactly what infrastructure will be created, changed, or deleted.    
**terraform apply**:  fires off the live API calls to physically build your configured resources in the cloud.  
**terraform destroy**: systematically tears down and deletes every cloud resource managed by that script.   
