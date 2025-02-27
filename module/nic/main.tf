/* resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
} */
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  accelerated_networking_enabled = length(var.network_interfaces) > 0 ? var.network_interfaces[0].accelerated_networking_enabled : false

  dynamic "ip_configuration" {
    for_each = { for idx, ip_config in flatten([
      for nic in var.network_interfaces : (
        length(lookup(nic, "nic_ip_config", [])) > 0 ? nic.nic_ip_config : [{
          name                          = "ipconfig-default"
          private_ip_address_allocation = "Dynamic"
        }]
      )
    ]) : idx => merge(ip_config, {primary = idx == 0 ? true : false} )}

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      primary = ip_configuration.value.primary
    }
  }
}
