data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.virtual_network.resource_group_name
}

data "azurerm_network_ddos_protection_plan" "this" {
  count               = try(var.virtual_network.ddos_protection_plan.name, null) != null ? 1 : 0
  name                = var.virtual_network.ddos_protection_plan.name
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network.name
  address_space       = var.virtual_network.address_space
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_servers         = var.virtual_network.dns_servers
  tags                = var.virtual_network.tags
  dynamic "ddos_protection_plan" {
    for_each = try(var.virtual_network.ddos_protection_plan.id, null) != null ? [1] : []
    content {
      id     = var.virtual_network.ddos_protection_plan.id
      enable = var.virtual_network.ddos_protection_plan.enable
    }
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags["CreatedOnDate"]
    ]
  }
}

module "subnet" {
  source          = "../subnet"
  virtual_network = local.virtual_network
  subnet          = var.virtual_network.subnets
}

# To expedite the completion of the assignment, I have prioritized essential resources and temporarily skipped
# some less critical resources like shown below.
# Subnet module is being called here with the variables mentioned in the variables.tf file but the subnet module is not present in the working dir.

# Similarly, DDoS protection plan module will be a separate module and is not part of this assessment.
