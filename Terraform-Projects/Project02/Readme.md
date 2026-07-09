## Project #2: Sample Azure Landing Zone Deployment

The goal of this project is to build aN **Azure Landing Zone (Enterprise-Scale)** framework. This framework establishes a secure, prebuilt, multi-subscription environment prepared for enterprise workloads to be deployed.

To make the code and architectural syntax easier to read and understand, the infrastructure is customized around a fictional company named after my dog, **Katsu** (Katsu Corp).

---

### 🧱 Architectural Blueprint & File Structure

An Infrastructure as Code (IaC) workspace is split into specialized files to ensure separated compartments and clean management. Here is how the components interact:

#### 1. `providers.tf` (The Remote Control Analogy)
This file configures Terraform to communicate securely with the Azure API by defining the required CLI version and enforcing AzureRM provider requirements using the pessimistic constraint operator (~>) to safely lock in major versions while allowing minor patches. Rather than deploying everything into a single environment, this configuration establishes an enterprise-grade, compartmentalized framework by leveraging provider aliases to map dedicated deployment pipelines into three distinct target subscriptions (Management, Connectivity, and Identity) alongside a fallback default. This multi-subscription boundary mirrors real-world cloud landing zones, demonstrating an understanding of how to minimize the security blast radius while keeping organizational billing easily segmented and managed.

#### 2. `variables.tf` (The Blueprints)
This file explicitly declares the input variables that our infrastructure expects (such as subscription IDs or naming prefixes). It acts like an empty form or blueprint defining *what kind* of information is required without hardcoding actual sensitive values.

#### 3. `terraform.tfvars` (The Input Data)
This file contains the actual data values that fill in the blanks left by `variables.tf`. This is where we assign the real, 36-character Azure subscription GUIDs and organizational names for Katsu Corp's platform.

#### 4. `main.tf` (The Builder)
This is the core file that orchestrates the execution. It pulls the structural definitions from `variables.tf`, injects the live account values from `terraform.tfvars`, and physically deploys the management group hierarchies, subscription associations, and foundational cloud infrastructure into Azure.

---

### 🌲 The Katsu Corp Hierarchy Tree

Instead of bundling all cloud assets into a single management group or subscription, this project maps out a multi-subscription landing zone designed for security isolation, billing separation, and landing zone scale:

```text
Root Management Group ("Katsu Corp Enterprise Infrastructure")
 ├── 📁 Platform Management Group (Core IT Infrastructure)
 │    ├── 💳 Management Subscription (Central logs, metrics, & monitoring)
 │    ├── 💳 Connectivity Subscription (Hub VNets, firewalls, & DNS zones)
 │    └── 💳 Identity Subscription (Active Directory & identity services)
 │
 └── 📁 Landing Zones Management Group (Business Applications)
      ├── 💳 Corp Subscription (Internal applications - private IPs only)
      └── 💳 Online Subscription (Public-facing websites & internet traffic)
