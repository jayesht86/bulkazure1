output "disk_ids" {
  #value = [for d in azurerm_managed_disk.disk : d.id]
  value = { for disk_key, disk in azurerm_managed_disk.disk : disk_key => disk.id }
}
