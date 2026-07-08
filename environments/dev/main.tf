module "resource_group" {
  source    = "../../child_modules/azurerm_resource_group"
  for_each  = var.rgdetails
  rgdetails = each.value
}

module "virtual_network" {
  source   = "../../child_modules/azurerm_virtual_network"
  for_each = var.vnetdetails
  vnetdetails = merge(each.value,
    {
      resource_group_name = module.resource_group[each.value.rg_key].name
      location            = module.resource_group[each.value.rg_key].location
  })
}

module "subnet" {
  source   = "../../child_modules/azurerm_subnet"
  for_each = var.subnetdetails
  subnetdetails = merge(each.value,
    {
      resource_group_name  = module.resource_group[each.value.rg_key].name
      virtual_network_name = module.virtual_network[each.value.vnet_key].name
  })
}

module "network_security_group" {
  source   = "../../child_modules/azurerm_nsg"
  for_each = var.nsgdetails
  nsgdetails = merge(each.value,
    {
      resource_group_name = module.resource_group[each.value.rg_key].name
      location            = module.resource_group[each.value.rg_key].location
    }
  )
}

module "network_security_group_subnet_association" {
  source   = "../../child_modules/azurerm_nsg_subnet_association"
  for_each = var.nsg_subnet_association
  nsg_subnet_association = {
    subnet_id                 = module.subnet[each.value.subnet_key].id
    network_security_group_id = module.network_security_group[each.value.nsg_key].id
  }
}

module "public_ip" {
  source   = "../../child_modules/azurerm_public_ip"
  for_each = var.publicipdetails
  publicipdetails = merge(each.value,
    {
      resource_group_name = module.resource_group[each.value.rg_key].name
      location            = module.resource_group[each.value.rg_key].location
  })
}

module "network_interface" {
  source   = "../../child_modules/azurerm_nic"
  for_each = var.nicdetails
  nicdetails = merge(each.value,
    {
      resource_group_name = module.resource_group[each.value.rg_key].name
      location            = module.resource_group[each.value.rg_key].location
      ip_configuration = merge(each.value.ip_configuration,
        {
          subnet_id            = module.subnet[each.value.ip_configuration.subnet_key].id
          public_ip_address_id = try(module.public_ip[each.value.ip_configuration.pip_key].id, null)
      })
  })
}

module "linux_virtual_machine" {
  source   = "../../child_modules/azurerm_linux_virtual_machine"
  for_each = var.linuxvmdetails
  linuxvmdetails = merge(each.value,
    {
      resource_group_name    = module.resource_group[each.value.rg_key].name
      location               = module.resource_group[each.value.rg_key].location
      network_interface_ids  = module.network_interface[each.value.nic_key].id
      os_disk                = each.value.os_disk
      source_image_reference = each.value.source_image_reference
  })
}

module "bastion" {
  source   = "../../child_modules/azurerm_bastion"
  for_each = var.bastiondetails
  bastiondetails = merge(each.value,
    {
      resource_group_name = module.resource_group[each.value.rg_key].name
      location            = module.resource_group[each.value.rg_key].location
      ip_configuration = merge(each.value.ip_configuration,
        {
          subnet_id            = module.subnet[each.value.ip_configuration.subnet_key].id
          public_ip_address_id = module.public_ip[each.value.ip_configuration.pip_key].id
      })
  })
}