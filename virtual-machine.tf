resource "azurerm_network_interface" "this" {
  name                = "${var.linux_virtual_machine.name}-nic"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  ip_configuration {
    name                          = "${var.linux_virtual_machine.name}-ip-config"
    subnet_id                     = element(azurerm_virtual_network.this.subnet[*].id, 0)
    private_ip_address_allocation = var.linux_virtual_machine.private_ip_address_allocation
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.linux_virtual_machine.name
  resource_group_name   = var.linux_virtual_machine.resource_group_name
  location              = data.azurerm_resource_group.this.location
  size                  = var.linux_virtual_machine.size
  network_interface_ids = [azurerm_network_interface.this.id]
  admin_username        = var.linux_virtual_machine.admin_username
  zone                  = var.linux_virtual_machine.zone_list
  source_image_id       = data.azurerm_shared_image_version.this.id
  admin_ssh_key {
    username   = var.linux_virtual_machine.admin_ssh_key.admin_username
    public_key = var.linux_virtual_machine.admin_ssh_key.public_key
  }
  os_disk {
    caching              = var.linux_virtual_machine.os_disk.caching
    storage_account_type = var.linux_virtual_machine.os_disk.storage_account_type
  }
  source_image_reference {
    publisher = var.linux_virtual_machine.source_image_reference.publisher
    offer     = var.linux_virtual_machine.source_image_reference.offer
    sku       = var.linux_virtual_machine.source_image_reference.sku
    version   = var.linux_virtual_machine.source_image_reference.version
  }
  tags = var.linux_virtual_machine.tags
}



