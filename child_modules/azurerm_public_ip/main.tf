resource "azurerm_public_ip" "this" {
  name                = var.publicipdetails.name
  resource_group_name = var.publicipdetails.resource_group_name
  location            = var.publicipdetails.location
  allocation_method   = var.publicipdetails.allocation_method

  tags = var.publicipdetails.tags
}
