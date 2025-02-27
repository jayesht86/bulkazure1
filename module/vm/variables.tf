variable "name" { 
    type = string 
    }
variable "location" { 
    type = string 
    }
variable "resource_group_name" { 
    type = string 
    }
variable "size" { 
    type = string 
    }
variable "admin_username" { 
    type = string 
    }
variable "admin_password" { 
    type = string 
    }
variable "os_disk_size_gb" { 
    type = number
    }
/* variable "nic_id" { 
    type = string
    } */
variable "nic_ids" { 
    type = list(string)
    }
variable "zones" { 
    type = list(string)
     }
variable "data_disk_ids" {
    type = list(string)
    default = []
}    
variable "linux_vm_os_disk_encryption_type" {
  description = "Encryption type for OS Disk"
  type        = string
  default     = null
}

variable "linux_vm_secure_boot_enabled" {
  description = "Enable secure boot for Gen2 VM"
  type        = bool
  default     = false
}

variable "linux_vm_vtpm_enabled" {
  description = "Enable vTPM for Gen2 VM"
  type        = bool
  default     = false
}

variable "linux_vm_host_encryption_enabled" {
  description = "Enable encryption at host level"
  type        = bool
  default     = false
}

variable "linux_vm_custom_data" {
  description = "Base64-encoded custom data for VM initialization"
  type        = string
  default     = null
}

variable "linux_vm_dedicated_host_id" {
  description = "Dedicated Host ID for VM placement"
  type        = string
  default     = null
}

variable "linux_vm_ultra_disks_enabled" {
  description = "Enable Ultra SSD capability"
  type        = bool
  default     = false
}

variable "linux_vm_boot_diag_uri" {
  description = "Storage Account URI for Boot Diagnostics"
  type        = string
  default     = null
}

variable "linux_vm_identity_type" {
  description = "Type of Managed Service Identity"
  type        = string
  default     = null
}

variable "linux_vm_identity_ids" {
  description = "User Assigned Managed Identity IDs"
  type        = list(string)
  default     = []
}

variable "linux_vm_custom_tags" {
  description = "Custom tags for VM"
  type        = map(string)
  default     = {}
}

