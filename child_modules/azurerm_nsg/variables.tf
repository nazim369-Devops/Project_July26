variable "nsgdetails" {
  description = "Network Security Group and its rules"
  type = object({
    name                = string
    location            = string
    resource_group_name = string

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
    tags = map(any)
  })
}

