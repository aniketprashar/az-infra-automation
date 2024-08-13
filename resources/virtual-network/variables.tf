variable "virtual_network" {
  type = object({
    name                = string,
    resource_group_name = string,
    address_space       = list(string),
    dns_servers         = list(string),
    tags                = map(string),
    ddos_protection_plan = optional(object({
      id     = string,
      enable = bool
    }))
    subnets = map(object({
      name                                           = string,
      address_prefixes                               = list(string),
      service_endpoints                              = list(string),
      enforce_private_link_service_network_policies  = bool,
      enforce_private_link_endpoint_network_policies = bool,
      delegation = list(object({
        name = string,
        service_delegation = list(object({
          name    = string,
          actions = list(string)
        }))
      }))
      route_table_name                = string,
      route_table_resource_group      = string,
      network_security_group          = string,
      network_security_resource_group = string
    }))
  })
  description = "An object that defines the configuration of an Azure Virtual Network (VNet). This includes the VNet's name, the associated resource group, address space, DNS servers, and optional DDoS protection plan. Additionally, it supports a a map of object for detailed subnet configuration, including service endpoints, private link policies, route tables, and network security groups."
  default     = {}
  validation {
    condition     = can(regex("^.{1,80}", var.virtual_network.name)) && can(regex("^([-\\w\\._]+[^\\.\\-])$", var.virtual_network.name))
    error_message = "The virtual network name must be between 1 and 80 characters. The name must begin with a letter or number and ends with a letter, number or underscore and may contain only letters, numbers, underscores, periods or hyphens"
  }
}
