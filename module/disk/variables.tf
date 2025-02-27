
variable "disk_size" {
  description = "The size of the disks for the VMs in GB."
  type        = number
  default     = 100  
}

variable "storage_account_type" {
  description = "The type of storage account for the disks (Standard_LRS, Premium_LRS)."
  type        = string
  default     = "Standard_LRS"  
}

variable "disk_count" {
  description = "Number of additional data disks to attach per VM."
  type        = number
  default     = 0  
}
variable "vm_name" {
  description = "The name of the VM associated with the disk"
  type        = string
}

variable "disks" {
  description = "List of disks for this VM"
  type = list(object({
    name = string
    size = number
  }))
}
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}
variable "zone" {
  type = string
}

