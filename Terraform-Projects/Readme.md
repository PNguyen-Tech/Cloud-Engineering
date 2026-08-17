# 🏗️ Terraform Infrastructure Portfolio

This is the repository for Cloud Engineering and Infrastructure as Code (IaC) development. This repository serves as a portfolio of my work architecting, provisioning, and automating secure cloud environments exclusively using Terraform.

---

## 📂 Repository Architecture

This repository contains practice projects designed to explore the deployment of modern cloud infrastructure using Terraform. The directory is structured as follows:

```text
/
├── README.md                 # Portfolio overview and documentation
└── terraform/                # Infrastructure as Code deployments
    ├── project-01/           # Base networking and core infrastructure (Creating multipe resource group, VNet, Subnet, NSG and a security rule)
    ├── project-02/           # Deploy a basic Azure Landing Zone, implementing enterprise cloud foundations including networking, security, identity, monitoring, and application infrastructure.
    ├── project-03/           # Identity, access management, and governance
    └── project-04/           # Secure key vaults and disk encryption

```
## 🛠️ Cloud Engineering Philosophy 

My infrastructure development is centered on the Azure Landing Zone (ALZ) conceptual framework, ensuring that all deployments are built upon a scalable, secure, and compliant foundation.

* **Policy-Driven Governance:** By applying Azure Policies at the management group level, I ensure that governance controls are inherited downward, creating a "secure by default" environment across the entire hierarchy.
* **Security Consistency:** Using Azure's inheritance model to ensure that every deployed resource automatically inherits the necessary security rules and configuration standards, eliminating manual configuration drift.
* **Reduce Workload:** By offloading the security and networking requirements to the landing zone, development teams can focus on application logic and resource optimization, significantly increasing delivery speed while maintaining strict security postures.
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
