resource "azurerm_bastion_host" "this" {
  name                = var.bastiondetails.name
  location            = var.bastiondetails.location
  resource_group_name = var.bastiondetails.resource_group_name

  ip_configuration {
    name                 = var.bastiondetails.ip_configuration.name
    subnet_id            = var.bastiondetails.ip_configuration.subnet_id
    public_ip_address_id = var.bastiondetails.ip_configuration.public_ip_address_id
  }
}
