# Azure Virtual Network Module

## Description

This Terraform module creates a standardized [Azure Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview).
Refer to the variables.tf for a full list of the possible options and default values.

## Inputs

| Name                 | Attribute Type | Description                                                                                                               | Data Type    | Default Value |
| -------------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------ | ------------- |
| name                 | Required       | The name of the virtual network. Changing this forces a new resource to be created.                                       | string       | none          |
| resource_group_name  | Required       | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | string       | none          |
| address_space        | Required       | The address space that is used the virtual network. You can supply more than one address space.                           | list(string) | none          |
| dns_servers          | Required       | List of IP addresses of DNS servers                                                                                       | list(string) | none          |
| tags                 | Required       | A mapping of tags to assign to the resource.                                                                              | map(string)  | none          |
| ddos_protection_plan | Optional       | A ddos_protection_plan block                                                                                              | object       | none          |
| subnets              | Required       | A subnets block                                                                                                           | map(object)  | none          |

## Reference

- [Azure Virtual Network Terraform Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
