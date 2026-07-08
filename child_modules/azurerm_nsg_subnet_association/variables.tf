variable "nsg_subnet_association" {
  type = object({
    subnet_id                 = string
    network_security_group_id = string
  })
}
