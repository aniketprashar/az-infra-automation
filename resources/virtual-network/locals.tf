locals {
  virtual_network = {
    virtual_network_name           = azurerm_virtual_network.this.name
    virtual_network_resource_group = var.virtual_network.resource_group_name
  }
}
