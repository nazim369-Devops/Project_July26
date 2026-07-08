variable "rgdetails" {
  type = object({
    resource_group_name = string
    location            = string
    tags                = map(any)
  })
}
