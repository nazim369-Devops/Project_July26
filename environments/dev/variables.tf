variable "rgdetails" {
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(any), {})
  }))
}

variable "vnetdetails" {
  type = map(object({
    name          = string
    rg_key        = string
    address_space = list(any)
  }))
}

variable "subnetdetails" {
  type = map(object({
    name             = string
    rg_key           = string
    vnet_key         = string
    address_prefixes = list(string)
  }))
}

variable "nsgdetails" {
  description = "Network Security Group and its rules"
  type = map(object({
    name   = string
    rg_key = string

    security_rule = map(object({
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
    tags = optional(map(any), {})
  }))
}

variable "nsg_subnet_association" {
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "publicipdetails" {
  type = map(object({
    name              = string
    rg_key            = string
    allocation_method = string
    tags              = optional(map(any), {})
  }))
}

variable "nicdetails" {
  type = map(object({
    name   = string
    rg_key = string
    ip_configuration = object({
      name                          = string
      private_ip_address_allocation = string
      subnet_key                    = string
      pip_key                       = optional(string, null)
    })
  }))
}

variable "linuxvmdetails" {
  type = map(object({
    name   = string
    rg_key = string

    size                            = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = bool

    nic_key = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}

variable "bastiondetails" {
  type = map(object({
    name   = string
    rg_key = string
    ip_configuration = object({
      name       = string
      subnet_key = string
      pip_key    = string
    })
  }))
}