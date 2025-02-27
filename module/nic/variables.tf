variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_name" {
  type = string
  
}
variable "network_interfaces" {
  type = list(object({
    name                          = optional(string)
    accelerated_networking_enabled = optional(bool, false)
    nic_ip_config = optional(list(object({
      name                          = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic")
      primary = optional(bool, false)
    })), [])
  }))
}
