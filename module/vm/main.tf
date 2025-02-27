resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.nic_ids
  size                  = var.size
  zone                  = var.zones[0] 
  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }
/*  dynamic "data_disk" {
   for_each = var.data_disk_ids
   content {
    lun = index(var.data_disk_ids, data_disk.value)
    caching = "ReadWrite"
    managed_disk_id = data_disk.value
    storage_account_type = "Standard_LRS"

   } 
   
 } */
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = var.name
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_disk" {

  for_each = { for idx, disk_id in var.data_disk_ids : idx => disk_id }
  managed_disk_id = each.value
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun = tonumber(each.key)
  caching = "ReadWrite"
}
