## Project #2: Sample Azure Landing Zone Deployment

The goal of this project is to build a foundational **Azure Landing Zone (Enterprise-Scale)** framework. This architecture establishes a secure, prebuilt, multi-subscription environment prepared for enterprise workloads to be deployed.

To make the code and architectural syntax easier to read and understand, the infrastructure is customized around a fictional company named after my dog, **Katsu** (Katsu Corp).

---

### 🧱 Architectural Blueprint & File Structure

An Infrastructure as Code (IaC) workspace is split into specialized files to ensure modularity and clean management. Here is how the components interact:

#### 1. `providers.tf` (The Remote Control)
This file configures Terraform to communicate with the Azure API, defining the exact core Terraform CLI version and the AzureRM provider requirements. 
> 💡 **Analogy:** Think of the provider block like a brand new **universal remote control**. Out of the box, it doesn't know how to control your specific television. You have to program the remote so it can communicate and map its buttons to work with your TV's brand. That is what a provider configuration does—it programs Terraform to translate your code into instructions the Azure API understands.

#### 2. `variables.tf` (The Blueprints)
This file explicitly declares the input variables that our infrastructure expects (such as subscription IDs or naming prefixes). It acts like an empty form or blueprint defining *what kind* of information is required without hardcoding actual sensitive values.

#### 3. `terraform.tfvars` (The Input Data)
This file contains the actual data values that fill in the blanks left by `variables.tf`. This is where we assign the real, 36-character Azure subscription GUIDs and organizational names for Katsu Corp's platform.

#### 4. `Project02.tf` (The Builder)
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
