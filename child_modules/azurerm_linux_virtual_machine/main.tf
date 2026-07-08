resource "azurerm_linux_virtual_machine" "this" {
  name                            = var.linuxvmdetails.name
  resource_group_name             = var.linuxvmdetails.resource_group_name
  location                        = var.linuxvmdetails.location
  size                            = var.linuxvmdetails.size
  admin_username                  = var.linuxvmdetails.admin_username
  admin_password                  = var.linuxvmdetails.admin_password
  disable_password_authentication = var.linuxvmdetails.disable_password_authentication
  network_interface_ids           = [var.linuxvmdetails.network_interface_ids]


  os_disk {
    caching              = var.linuxvmdetails.os_disk.caching
    storage_account_type = var.linuxvmdetails.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.linuxvmdetails.source_image_reference.publisher
    offer     = var.linuxvmdetails.source_image_reference.offer
    sku       = var.linuxvmdetails.source_image_reference.sku
    version   = var.linuxvmdetails.source_image_reference.version
  }
}
