resource "azurerm_virtual_network" "this" {
  name                = var.vnetdetails.name
  location            = var.vnetdetails.location
  resource_group_name = var.vnetdetails.resource_group_name
  address_space       = var.vnetdetails.address_space
}