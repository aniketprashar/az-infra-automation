variable "ddos_protection_plan_id" {
  type = string
}
variable "ddos_protection_plan_enable" {
  type = bool
}
variable "vnet_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "dns_servers" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "subnet_name" {
  type = string
}
variable "address_prefixes" {
  type = list(string)
}
variable "service_endpoints" {
  type = list(string)
}
variable "enforce_private_link_service_network_policies" {
  type = bool
}
variable "enforce_private_link_endpoint_network_policies" {
  type = bool
}
variable "delegation_name" {
  type = string
}
variable "service_delegation_name" {
  type = string
}
variable "service_delegation_actions" {
  type = list(string)
}
variable "route_table_name" {
  type = string
}
variable "route_table_resource_group" {
  type = string
}
variable "network_security_group" {
  type = string
}
variable "network_security_resource_group" {
  type = string
}
