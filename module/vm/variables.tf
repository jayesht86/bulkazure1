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
