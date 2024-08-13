module "resource-group" {
  source = "../resource-group"
  resource_group = {
    rg1 = {
      resource_group_name = "AniketRG",
      location            = "EastUS2",
      tags = {
        "Environment"   = "Development"
        "CreatedOnDate" = "10-Aug-2024"
      }
    }
  }
}
