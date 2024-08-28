virtual_network = {
  name                = "azccoedevvnet01"
  resource_group_name = "az-ccoedev-infra-automation"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  subnets = {
    subnet01 = {
      name           = "azccoedevsubnet01"
      address_prefix = "10.0.1.0/24"
    }
  }
  tags = {
    environment = "dev"
    owner       = "TeamParashar"
  }
}

lb = {
  name                           = "azccoedevlb01",
  resource_group_name            = "az-ccoedev-infra-automation",
  allocation_method              = "Static"
  pip_name                       = "azccoedevpip01",
  frontend_ip_configuration_name = "PublicIPAddress"
}

linux_virtual_machine = {
  name                          = "azccoedevvm01",
  resource_group_name           = "az-ccoedev-infra-automation",
  private_ip_address_allocation = "Dynamic",
  size                          = "Standard_D4_v5",
  tags = {
    environment = "dev"
    owner       = "TeamParashar"
  }
  admin_username = "aniketprashar",
  os_disk = {
    caching              = "ReadWrite",
    storage_account_type = "Standard_LRS"
  },
  source_image_reference = {
    offer     = "0001-com-ubuntu-server-jammy",
    publisher = "Canonical",
    version   = "latest",
    sku       = "22_04-lts"
  },
  admin_ssh_key = {
    admin_username = "aniketprashar",
    public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCy7G3OqJ7Gp3MZH8Z73G8k7aBhsB2zEXAMPLEKEYzKLNmNTxwJ0FrKDHTYMyVr7NmPzI7b+2i6S3i+oE6xxuHH7Q1LRbW4J4vFsqDDeKrPdd72UObRdeuN6Pz7+fPE8CgMZqx0jXghfpciFepQt4MrZP1Hg4nbn1NkVejsDFzkHt0B+MgMzVq5A4lO1JjFBoJ2uYrmAqwX3+v7RNTNu0ZBoqQo3uJzVtnCrkXNyIh0t9pZ/H4V8s7Fhng5fISGfR6+V6hJhWl+jC9IFQKZDpuXNa6NEbWuM8NeMb0wS9xvIt1PO7uFMIgHGH9u5N50G0vDHrM9uz1rh8AE3nWpMhd username@example.com"
  }
}

