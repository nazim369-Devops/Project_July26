resource "azurerm_network_security_group" "this" {
  name                = var.nsgdetails.name
  location            = var.nsgdetails.location
  resource_group_name = var.nsgdetails.resource_group_name

  dynamic "security_rule" {

    for_each = var.nsgdetails.security_rule
    iterator = rule
    content {
      name                       = rule.key
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix
    }
  }
  tags = var.nsgdetails.tags
}