variable "linux_virtual_machine" {
  type = object({
    name                   = string,
    resource_group_name    = string
    size                   = optional(string, "Standard_D4_v5"),
    tags                   = map(string),
    zone_list              = optional(list(number), []),
    ultra_ssd_enabled      = optional(bool, false),
    license_type           = optional(string),
    storage_account_uri    = optional(string, null),
    enable_boot_diagnostic = optional(bool, false),
    dns_servers            = optional(list(string), []),
    admin_username         = string,
    admin_ssh_key = object({
      admin_username = string,
      public_key     = string
    })
    subnet = object({
      name                          = string,
      virtual_network_name          = string,
      vnet_resource_group           = string,
      private_ip_address_allocation = optional(string, "Dynamic")
    }),
    identity_list = map(object({
      name                = string,
      resource_group_name = string
    })),
    os_disk = object({
      caching              = string,
      storage_account_type = string,
      disk_size_gb         = optional(number, 256),
      disk_encryption_set  = optional(string, null)
    }),
    data_disk = optional(object({
      caching = string,
      name    = list(string)
    })),
    source_image = object({
      name                 = string,
      version              = optional(string, latest),
      gallery_name         = string,
      image_resource_group = string
    })
  })
}
