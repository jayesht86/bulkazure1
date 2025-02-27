
module "vm" {
  source              = "C:\\Azure\\azurebulkvm_new\\module\\vm"
  for_each = { for idx, vm in local.vm_list : "${vm.name}-${idx}" => vm }
  
  name                = each.value.name
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  os_disk_size_gb     = each.value.os_disk_size_gb
  zones               = [each.value.zone]
  resource_group_name = var.resource_group_name
  location            = var.location
  #nic_id              = module.nic[each.key].id  
  nic_ids             = try(local.vm_nic_map[each.value.name], [])
  data_disk_ids = (contains(keys(module.disk), each.key) ? values(module.disk[each.key].disk_ids) : [] )
}

module "nic" {
  source = "C:\\Azure\\azurebulkvm_new\\module\\nic"
/*   for_each = {
    for idx, vm in local.vm_list : 
    "${vm.name}-${idx}" => vm  
  } */
  for_each = {
    for vm in local.vm_list : vm.name => vm.network_interfaces
  }

  resource_group_name = var.resource_group_name
  #name                = "${each.value.name}-nic-${each.key}"
  location            = var.location
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  vm_name             = each.key
  network_interfaces  = each.value
}
locals {
  vm_nic_map = {
    for vm in local.vm_list : vm.name => [
      for nic in vm.network_interfaces : try(module.nic["${vm.name}-${nic.name}"].id, null) ] if length(vm.network_interfaces) > 0
  }
}

module "disk" {
  for_each = { for idx, vm in local.vm_list : "${vm.name}-${idx}" => vm }

  source              = "C:\\Azure\\azurebulkvm_new\\module\\disk"
  vm_name             = each.value.name
  zone                = each.value.zone
  disks = [
    { name = "${each.value.name}-data-disk-${each.key}", size = 64 },
    #{ name = "${each.value.name}-data-disk2-${each.key}", size = 128 },
    #{ name = "${each.value.name}-data-disk3-${each.key}", size = 256 }
  ]
  resource_group_name = var.resource_group_name
  location            = var.location
}
