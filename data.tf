data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
}
