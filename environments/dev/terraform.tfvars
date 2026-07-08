rgdetails = {
  rg1 = {
    resource_group_name = "rg-dev-sbi"
    location            = "central india"
    tags = {
      environment  = "dev"
      organisation = "sbi"
      managed_by   = "terraform"
    }
  }
}
vnetdetails = {
  vnet1 = {
    name          = "dev-vnet-01"
    rg_key        = "rg1"
    address_space = ["10.0.0.0/16"]
  }
}

subnetdetails = {
  subnet1 = {
    name             = "frontend-subnet"
    rg_key           = "rg1"
    vnet_key         = "vnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "backend-subnet"
    rg_key           = "rg1"
    vnet_key         = "vnet1"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet3 = {
    name             = "AzureBastionSubnet"
    rg_key           = "rg1"
    vnet_key         = "vnet1"
    address_prefixes = ["10.0.3.0/26"]
  }
}

nsgdetails = {
  nsg1 = {
    name   = "nsg-front-subnet"
    rg_key = "rg1"
    security_rule = {
      HTTP = {
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      SSH = {
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
  nsg2 = {
    name   = "nsg-back-subnet"
    rg_key = "rg1"
    security_rule = {
      HTTP = {
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      SSH = {
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

nsg_subnet_association = {
  nsg1_subnet1 = {
    nsg_key    = "nsg1"
    subnet_key = "subnet1"
  }
  nsg2_subnet2 = {
    nsg_key    = "nsg2"
    subnet_key = "subnet2"
  }
}

publicipdetails = {
  pip1 = {
    name              = "bastion_pip"
    rg_key            = "rg1"
    allocation_method = "Static"
    tags = {
      environment = "dev"
    }
  }
  pip2 = {
    name              = "appl_gw_pip"
    rg_key            = "rg1"
    allocation_method = "Static"
  }
  pip3 = {
    name              = "nat_pip"
    rg_key            = "rg1"
    allocation_method = "Static"
    tags = {
      environment = "dev"
    }
  }
}

nicdetails = {
  nic1 = {
    name   = "frontend-vm-nic-01"
    rg_key = "rg1"

    ip_configuration = {
      name                          = "internal"
      private_ip_address_allocation = "Dynamic"
      subnet_key                    = "subnet1"
      pip_key                       = null
    }
  }
  nic2 = {
    name   = "backend-vm-nic-01"
    rg_key = "rg1"

    ip_configuration = {
      name                          = "internal"
      private_ip_address_allocation = "Dynamic"
      subnet_key                    = "subnet2"
      pip_key                       = null
    }
} }

linuxvmdetails = {
  vm1 = {
    name   = "vm-01-front-dev"
    rg_key = "rg1"

    size                            = "Standard_D2s_v3"
    admin_username                  = "terraformuser-vm1"
    admin_password                  = "Password@13farm"
    disable_password_authentication = false

    nic_key = "nic1"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  vm2 = {
    name   = "vm-02-back-dev"
    rg_key = "rg1"

    size                            = "Standard_D2s_v3"
    admin_username                  = "terraformuser-vm2"
    admin_password                  = "Password@13farm"
    disable_password_authentication = false

    nic_key = "nic2"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}

bastiondetails = {
  bastion1 = {
    name   = "dev-bastion"
    rg_key = "rg1"
    ip_configuration = {
      name       = "configuration"
      subnet_key = "subnet3"
      pip_key    = "pip1"
    }
  }
}