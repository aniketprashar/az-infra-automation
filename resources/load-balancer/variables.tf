variable "lb" {
  type = object({
    name     = string,
    sku      = optional(string, "Standard")
    sku_tier = optional(string, "Regional")
    tags     = map(string),
    frontend_ip_congiguration = map(object({
      name                          = string,
      zones                         = optional(list(string), ["1", "2", "3"]),
      private_ip_address_allocation = string,
      private_ip_address            = string
    })),
    backend_address_pool = object({
      name       = string,
      ip_address = list(string),
      health_probes = map(object({
        name                = string,
        port                = number,
        protocol            = string,
        request_path        = optional(string, null),
        interval_in_seconds = optional(number, null),
        number_of_probes    = optional(number, null)
      }))
      lb_rule = map(object({
        name                           = string,
        protocol                       = string,
        frontend_port                  = number,
        backend_port                   = number,
        frontend_ip_congiguration_name = string,
        probe_name                     = string,
        enable_floating_ip             = bool,
        idle_timeout_in_minutes        = number,
        enable_tcp_reset               = bool,
        load_distribution              = optional(string)
      })),
    }),
    subnet = object({
      name                 = string,
      virtual_network_name = string,
      vnet_resource_group  = string
    }),
  })
}
