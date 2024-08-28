resource "azurerm_public_ip" "this" {
  name                = var.lb.pip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.lb.allocation_method
}

resource "azurerm_lb" "this" {
  name                = var.lb.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  dynamic "frontend_ip_configuration" {
    for_each = var.lb.frontend_ip_configuration
    content {
      name                 = each.value.name
      public_ip_address_id = azurerm_public_ip.this.id
    }
  }
}





