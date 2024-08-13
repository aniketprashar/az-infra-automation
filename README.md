# Infrastructure Automation with Terraform, GitHub Actions, and Azure

## Overview

This project demonstrates the use of Terraform for provisioning Azure resources, automated with GitHub Actions. The setup includes creating a GitHub repository, configuring OIDC authentication, and defining infrastructure components such as virtual networks, virtual machines, and load balancers.

## Completed Work

### GitHub Repository Setup

- Repository Created: az-infra-automation. Currently, made the repository public so that it's easier to share.
- GitHub Environment: Created a "Development" environment for deploying resources.
- Added Variables and Secrets in the `Development` environment.
- Created Branch policies so that the `main` branch is protected from unintended changes.

### OIDC Authentication

Not Configured: Currently, I don't have any free azure subscription. I am quite aware of how to setup authentication on Azure with Azure DevOps and Harness but haven't done OIDC authentication before. It should be similar to Azure devOps where we do the following steps.

- Create Azure AD Application
- Create Service Principal
- Create Client Secret
- Add `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` as secret/variable.
- Use these variables in the Azure Login pipeline step.

### Terraform Configuration

| Module Name      | Status                                                                                   |
| ---------------- | ---------------------------------------------------------------------------------------- |
| Resource Groups  | Created module and configuration for managing Azure Resource Groups.                     |
| Virtual Networks | Defined and configured Azure Virtual Networks, including address spaces and DNS servers. |
| Virtual Machines | Defined virtual machines Terraform module with base configurations.                      |
| Load Balancers   | Defined Azure Load Balancer Terraform module with base configurations                    |

### GitHub Actions

**Terraform Plan:** Added GitHub Action to trigger a Terraform plan when a pull request is raised.

**Terraform Apply:** Added GitHub Action to apply Terraform changes when a pull request is merged to the main branch.

### Collaboration

Created a comprehensive README file for Virtual Networks to illustrate how to effectively design, deploy, and manage VNets within our infrastructure. This documentation serves as a guide for team members to understand the architecture, configuration, and best practices associated with VNets.

To expedite the completion of the assignment, I have prioritized essential tasks and temporarily skipped some less critical elements, such as creating README files for all modules. Ideally, these README files should be included in each module directory to provide comprehensive documentation and support effective collaboration.
