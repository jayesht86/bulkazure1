locals {
  vm_list = flatten([
    for config in var.vm_config : [
      for idx,zone in config.zone_list : {

          name            = format("%s%s%s%s%02d", var.region_code, var.product_code, var.environment_code, zone, idx + 1+ var.sequence_start)
          size            = config.size
          admin_username  = config.admin_username
          admin_password  = config.admin_password
          os_disk_size_gb = config.os_disk_size_gb
          zone            = zone

          network_interfaces = concat(
            lookup(config, "linux_vm_default_nic", []),
            lookup(config, "linux_vm_additional_nic", [])
          )
        }
      ]
    ]
  )
}
