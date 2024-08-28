virtual_network = {
  name                = "azccoedevvnet01"
  resource_group_name = "az-ccoedev-infra-automation"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  subnet = {
    name           = "azccoedevsubnet01"
    address_prefix = "10.0.1.0/24"
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
  size                          = "Standard_F2",
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
    public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlf/u04qE2fXcwbZ2fPT01d9vtk/RRLCc9q072SYB8Qu76eWWmN4L6fTCI0H5rmG+4qU0YTT/hyqcK/Nj6yFumVoNW6Pbwni0iRUA96cZOjpXJUtwgFH0Fc+L3PfElJU9RXpCXQkYSV4KnWgMjdhQmOxjRBje53uwZusyZWfvK6tvto7pp9qVytCsG2Yd/ZdekpwPrkRSZftTIxFqdOuEztmYYHEdynJ/RwcPrKdrTV5I/D4CqAqbHkpW7DSVIEnWtuWxyQkxJ1+zwaPnhSBRXkJE7rw3mqBxhukTSJM1lSnAmodXVEmCq3mvAmX0XcNT9JQZPvIHBlPc16nXBvEZHk/F/65bENYqqf1DUlAQ1O5uwOSs9MJyzdIM4gIcvTQGav+FigdiMncYoLpFMGa27zMOobx1SXJDskdlSRD38wuSQHtlFMzBC474cXWZg4Pp1smiOCykndQsvgNK4OsBoeXaPOuCGG8c4AVuLDYPWCvZuGVy1IAXCXqzL/2zFMt0= generated-by-azure"
  }
}

