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
  subnet {
    name             = var.virtual_network.subnet.name
    address_prefixes = [var.virtual_network.subnet.address_prefix]
  }
}
