resource "azurerm_network_interface" "this" {
  name                = var.nicdetails.name
  location            = var.nicdetails.location
  resource_group_name = var.nicdetails.resource_group_name

  ip_configuration {
    name                          = var.nicdetails.ip_configuration.name
    subnet_id                     = var.nicdetails.ip_configuration.subnet_id
    private_ip_address_allocation = var.nicdetails.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = var.nicdetails.ip_configuration.public_ip_address_id
  }
}

