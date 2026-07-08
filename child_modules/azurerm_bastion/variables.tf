variable "bastiondetails" {
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    ip_configuration = object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    })
  })
}