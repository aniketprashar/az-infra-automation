resource "azurerm_resource_group" "this" {
  for_each = var.resource_group
  name     = each.value.resource_group_name
  location = each.value.location
  tags     = each.value.tags
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags["CreatedOnDate"]
    ]
  }
}
