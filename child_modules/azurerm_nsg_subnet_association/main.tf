resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = var.nsg_subnet_association.subnet_id
  network_security_group_id = var.nsg_subnet_association.network_security_group_id
}