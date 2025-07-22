resource "azurerm_virtual_network" "myvnet" {
    resource_group_name = var.resource_group_name
    location = var.location
    name = prodvnet
    address_space = ["10.0.0.0/24"]
    }