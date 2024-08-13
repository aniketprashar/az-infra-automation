data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.linux_virtual_machine.resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.lb.subnet.virtual_network_name
  resource_group_name = var.lb.subnet.resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = var.lb.subnet.name
  virtual_network_name = var.lb.subnet.virtual_network_name
  resource_group_name  = var.lb.subnet.resource_group_name
}

resource "azurerm_lb" "this" {
  name                = var.lb.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  sku                 = var.lb.sku
  sku_tier            = var.lb.sku_tier
  dynamic "frontend_ip_configuration" {
    for_each = var.lb.frontend_ip_configuration
    content {
      name                          = each.value.name
      subnet_id                     = data.azurerm_subnet.this.id
      private_ip_address_allocation = each.value.private_ip_address_allocation
      private_ip_address            = each.value.private_ip_address
      zones                         = each.value.zones
    }
  }
  tags = var.lb.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  count           = var.lb.backend_address_pool != null ? 1 : 0
  loadbalancer_id = azurerm_lb.this.id
  name            = var.lb.backend_address_pool.name
}

resource "azurerm_lb_backend_address_pool_address" "this" {
  count                   = length(var.lb.backend_address_pool.ip_address)
  name                    = "${var.lb.backend_address_pool.name}-${count.index + 1}-ip"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this[0].id
  virtual_network_id      = data.azurerm_virtual_network.this.id
  ip_address              = element(var.lb.backend_address_pool.ip_address, count.index)
}

resource "azurerm_lb_probe" "this" {
  for_each            = var.lb.backend_address_pool.health_probes
  loadbalancer_id     = azurerm_lb.this.id
  name                = each.value.name
  port                = each.value.port
  protocol            = each.value.protocol
  request_path        = each.value.request_path
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
}

resource "azurerm_lb_rule" "this" {
  for_each                       = var.lb.backend_address_pool.lb_rule
  loadbalancer_id                = azurerm_lb.this.id
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_ids       = ["${azurerm_lb_backend_address_pool.this[0].id}"]
  probe_id                       = azurerm_lb_probe.this[each.value.probe_name].id
  enable_floating_ip             = each.value.enable_floating_ip
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  enable_tcp_reset               = each.value.enable_tcp_reset
  load_distribution              = each.value.load_distribution
}

# To expedite the completion of the assignment, I have prioritized essential resources and temporarily skipped
# some less critical resources like shown below.

# resource "azurerm_private_dns_a_record" "this" {}

# resource "azurerm_lb_nat_rule" "this" {}

# resource "azurerm_lb_nat_pool" "this" {}





