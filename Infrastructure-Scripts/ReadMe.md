
# Cloud Infrastructure Scripts

A collection of Python scripts for automating Microsoft Azure infrastructure management, cost optimization, and administrative tasks. 

This repository serves as a portfolio of cloud engineering tools designed to solve real-world operational challenges using the Azure SDK for Python.

## 📂 Catalog of Scripts

| Script Name | Description | Key Services |
| :--- | :--- | :--- |
| **`vm-auto-stop.py`** | Automates cost savings by identifying and deallocating specific Virtual Machines by tags and resource group. | Compute, Tags |
| **`VM-error-scanner.py`** | Script automates the monitoring of Azure Virtual Machines to identify instances that are in a failed or error state. | Compute, Tags |
| *(Coming Soon)* | *Future scripts for Storage Account management and Network security checks.* | ... |

---

## 🚀 Feature: VM Auto-Stopper (`vm-auto-stop.py`)

This script helps reduce cloud spend by automatically finding Virtual Machines that are meant for development (tagged `Environment: Dev`) and ensuring they are deallocated.

**Key Logic:**
1. Authenticates securely using `DefaultAzureCredential`.
2. Scans a target Resource Group for VMs.
3. Filters for VMs with specific tags (e.g., `Environment: Dev`).
4. Checks the **Instance View** to see if the VM is currently `Running`.
5. **Action:** Deallocates the VM to stop billing.
6. **Safety:** Includes a `DRY_RUN` flag to simulate actions without affecting production.

---

## 🔍 Feature: VM Error Scanner (`VM_error_scanner.py`)

This script improves infrastructure observability by automatically scanning the subscription for Virtual Machines that have fallen into a "Failed" or unhealthy state, which might otherwise go unnoticed without manual portal checks.

**Key Logic:**

1.  **Authenticates** securely using `DefaultAzureCredential`.
2.  **Iterates** through all Virtual Machines in the subscription (or a specific Resource Group).
3.  **Retrieves** the **Instance View** for each VM to access real-time status codes.
4.  **Filters** the results to isolate VMs that are not in a healthy or successful state by two conditions.
5.  **Reporting:** specific details (VM Name, Resource Group, and Error Code) are printed to the console for immediate viewing. 

---

## 🛠️ Prerequisites

To run these scripts, you will need:

* **Python 3.8+**
* **Azure CLI** (for local authentication)
* **Azure Subscription** (with permissions to manage resources)

### Required Libraries
```bash
python -m pip install azure-identity azure-mgmt-compute
