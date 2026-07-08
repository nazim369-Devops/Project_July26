resource "azurerm_resource_group" "this" {
  name     = var.rgdetails.resource_group_name
  location = var.rgdetails.location
  tags     = var.rgdetails.tags
}
