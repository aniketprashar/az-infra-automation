variable "virtual_network" {
  type = object({
    name                = string,
    resource_group_name = string,
    address_space       = list(string),
    dns_servers         = list(string),
    tags                = map(string),
    subnets = map(object({
      name           = string,
      address_prefix = string
    }))
  })
  description = "An object that defines the configuration of an Azure Virtual Network (VNet). This includes the VNet's name, the associated resource group, address space, DNS servers, and optional DDoS protection plan. Additionally, it supports a a map of object for detailed subnet configuration, including service endpoints, private link policies, route tables, and network security groups."
  validation {
    condition     = can(regex("^.{1,80}", var.virtual_network.name)) && can(regex("^([-\\w\\._]+[^\\.\\-])$", var.virtual_network.name))
    error_message = "The virtual network name must be between 1 and 80 characters. The name must begin with a letter or number and ends with a letter, number or underscore and may contain only letters, numbers, underscores, periods or hyphens"
  }
}

variable "lb" {
  type = object({
    name                           = string,
    resource_group_name            = string,
    allocation_method              = string,
    pip_name                       = string,
    frontend_ip_configuration_name = string
  })
}

variable "linux_virtual_machine" {
  type = object({
    name                          = string,
    resource_group_name           = string,
    private_ip_address_allocation = string,
    size                          = optional(string, "Standard_D4_v5"),
    tags                          = map(string),
    admin_username                = string,
    os_disk = object({
      caching              = string,
      storage_account_type = string
    }),
    source_image_reference = object({
      offer     = string,
      publisher = string,
      version   = string,
      sku       = string
    }),
    admin_ssh_key = object({
      admin_username = string,
      public_key     = string
    })
  })
}



