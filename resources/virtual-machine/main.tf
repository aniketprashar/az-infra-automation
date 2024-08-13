data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.linux_virtual_machine.resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = var.linux_virtual_machine.subnet.name
  virtual_network_name = var.linux_virtual_machine.subnet.virtual_network_name
  resource_group_name  = var.linux_virtual_machine.subnet.resource_group_name
}

data "azurerm_shared_image_version" "this" {
  name                = var.linux_virtual_machine.source_image.version
  image_name          = var.linux_virtual_machine.source_image.name
  gallery_name        = var.linux_virtual_machine.source_image.gallery_name
  resource_group_name = var.linux_virtual_machine.source_image.image_resource_group
}

data "azurerm_managed_disk" "this" {
  for_each            = length(var.linux_virtual_machine.data_disk.name) > 0 ? { for key, value in var.linux_virtual_machine.data_disk.name : key => value } : {}
  name                = each.value
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_user_assigned_identity" "this" {
  for_each            = var.linux_virtual_machine.identity_list
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_disk_encryption_set" "this" {
  count               = var.linux_virtual_machine.os_disk.disk_encryption_set != null ? 1 : 0
  name                = var.linux_virtual_machine.os_disk.disk_encryption_set
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_ssh_public_key" "this" {
  count               = substr(var.linux_virtual_machine.admin_ssh_key.public_key, 0, 7) != "ssh-rsa" ? 1 : 0
  name                = var.linux_virtual_machine.admin_ssh_key.public_key
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_network_interface" "this" {
  name                = "${var.linux_virtual_machine.name}-nic"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  ip_configuration {
    name                          = "${var.linux_virtual_machine.name}-ip-config"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = var.linux_virtual_machine.subnet.private_ip_address_allocation
  }
  tags = var.linux_virtual_machine.tags
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
  os_disk {
    caching                = var.linux_virtual_machine.os_disk.caching
    storage_account_type   = var.linux_virtual_machine.os_disk.storage_account_type
    disk_size_gb           = var.linux_virtual_machine.os_disk.disk_size_gb
    disk_encryption_set_id = var.linux_virtual_machine.os_disk.disk_encryption_set != null ? data.azurerm_disk_encryption_set.this[0].id : null
  }
  admin_ssh_key {
    username   = var.linux_virtual_machine.admin_ssh_key.admin_username
    public_key = substr(var.linux_virtual_machine.admin_ssh_key.public_key, 0, 7) != "ssh-rsa" ? data.azurerm_ssh_public_key.this.0.public_key : var.linux_virtual_machine.admin_ssh_key.public_key
  }
  identity {
    type         = length(data.azurerm_user_assigned_identity.this) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = length(data.azurerm_user_assigned_identity.this) > 0 ? values(data.azurerm_user_assigned_identity.this)[*].id : null
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags["CreatedOnDate"]
    ]
  }
  tags = var.linux_virtual_machine.tags
}

resource "null_resource" "disable_public_access" {
  triggers = {
    execution_time = timestamp()
  }
  provisioner "local-exec" {
    command = "az disk update --name ${azurerm_linux_virtual_machine.this.os_disk[0].name} --resource-group ${data.azurerm_resource_group.this.name} --public-network-access Disabled --network-access-policy DenyAll"
  }
  depends_on = [azurerm_linux_virtual_machine.this]
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each           = length(var.linux_virtual_machine.data_disk.name) > 0 ? { for key, value in var.linux_virtual_machine.data_disk.name : key => value } : {}
  managed_disk_id    = data.azurerm_managed_disk.this[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.this.id
  lun                = each.key + 1
  caching            = var.linux_virtual_machine.os_disk.caching
}

# To expedite the completion of the assignment, I have prioritized essential resources and temporarily skipped
# some less critical resources like shown below.

# resource "azurerm_virtual_machine_extension" "this" {}

# Storage account for bootdiagnostic
# data "azurerm_storage_account" "this" {}

# Virtual Machine Alerts, Generic Extensions -> will be a separate terraform module and will be called here

# module "linux-VM-alerts" {
#   source = ""
# }

# module "Extensions" {
#   source = ""
# }



