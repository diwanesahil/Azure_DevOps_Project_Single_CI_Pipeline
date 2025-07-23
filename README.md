# Project Notes

This project is created to deploy Azure storage account using Terraform with Azure DevOps CICD pipeline. We have created single yaml file for end to end execution.
Used Variable groups to pass the values for remote backend. Also used replaced token task to to fetch the values for variable.tfvars from variable group. Used script to verify replaced token details from variabe group.

## File Overview

- **Provider.tf**: Configures the Terraform provider for Azure (azurerm) and sets up the backend for state management.
- **Variable.tf**: Declares input variables for resource group name, location, and storage account name.
- **variable.tfvars**: Provides values for the variables defined in `Variable.tf`. Uses pipeline variable substitution for CI/CD.
- **storage.tf**: Defines resources for Azure Resource Group and Storage Account using the provided variables.
- **vnet.tf**: (Currently commented out) Intended for defining an Azure Virtual Network resource. Uncomment and update as needed.
- **azure-pipelines.yml**: Azure DevOps pipeline for automating Terraform operations (init, validate, plan, apply). Uses the `TerraformTask@5` task—ensure the correct extension is installed in Azure DevOps.

## Usage Notes

1. Update `variable.tfvars` with your actual values or ensure pipeline variables are set in Azure DevOps.
2. Make sure the Azure DevOps organization has the required Terraform extension installed for pipeline compatibility.
3. Uncomment and configure `vnet.tf` if you need to deploy a virtual network.
4. The pipeline expects a service connection and backend configuration variables to be set in Azure DevOps.

## Troubleshooting

- If you see pipeline errors, check the task version and extension installation in Azure DevOps.
- For Terraform errors, ensure all required variables are provided and resources are properly referenced.
  

## Azure DevOps Pipeline (azure-pipelines.yml) Step-by-Step

1. **Trigger**: The pipeline is triggered on changes to the `main` branch.

2. **Variables**: Uses a variable group `TerraformBackendConfig` for backend and service connection settings. These variables must be defined in Azure DevOps.

3. **Stage: Build**: Contains a single job named `Build` that runs on an Ubuntu agent.

4. **TerraformInstaller@1**: Installs the latest version of Terraform on the build agent.

5. **TerraformTask@5 (Init)**: Initializes Terraform with Azure backend configuration. Uses pipeline variables for resource group, storage account, container, and state file.

6. **TerraformTask@5 (Validate)**: Validates the Terraform configuration files to ensure syntax and configuration correctness.

7. **TerraformTask@5 (Plan)**: Runs `terraform plan` to preview changes. Uses the Azure service connection for authentication.

8. **TerraformTask@5 (Apply)**: Applies the planned changes to Azure resources. Also uses the Azure service connection for authentication.

