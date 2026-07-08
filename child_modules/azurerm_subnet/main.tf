resource "azurerm_subnet" "this" {
  name                 = var.subnetdetails.name
  resource_group_name  = var.subnetdetails.resource_group_name
  virtual_network_name = var.subnetdetails.virtual_network_name
  address_prefixes     = var.subnetdetails.address_prefixes
}
