output "resource_group_name" {
  value = [for rg_name in azurerm_resource_group.this : rg_name.name]
}
output "resource_group_location" {
  value = [for rg_loc in azurerm_resource_group.this : rg_loc.location]
}
