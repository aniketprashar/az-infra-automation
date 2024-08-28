data "azurerm_resource_group" "this" {
  name = var.virtual_network.resource_group_name
}

resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network.name
  address_space       = var.virtual_network.address_space
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_servers         = var.virtual_network.dns_servers
  tags                = var.virtual_network.tags
  dynamic "subnet" {
    for_each = var.virtual_network.subnets
    content {
      name             = each.value.name
      address_prefixes = [each.value.address_prefix]
    }
  }
}
