variable "resource_group" {
  type = map(object({
    resource_group_name = string,
    location            = string,
    tags                = map(string)
  }))
  description = "A map of objects representing Azure resource groups."
  default     = {}
}
