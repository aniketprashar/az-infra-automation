module "virtual-network" {
  source = "../resources/virtual-network"
  virtual_network = {
    name                = var.vnet_name,
    resource_group_name = var.resource_group_name,
    address_space       = var.address_space,
    dns_servers         = var.dns_servers,
    tags                = var.tags,
    ddos_protection_plan = {
      id     = var.ddos_protection_plan_id,
      enable = var.ddos_protection_plan_enable
    },
    subnets = {
      subnetA = {
        name                                           = var.subnet_name
        address_prefixes                               = var.address_prefixes
        service_endpoints                              = var.service_endpoints
        enforce_private_link_service_network_policies  = var.enforce_private_link_service_network_policies,
        enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies,
        delegation = {
          name = var.delegation_name,
          service_delegation = {
            name    = var.service_delegation_name,
            actions = var.service_delegation_actions
          }
        }
        route_table_name                = var.route_table_name,
        route_table_resource_group      = var.route_table_resource_group,
        network_security_group          = var.network_security_group,
        network_security_resource_group = var.network_security_resource_group
      }
    }
  }
}
