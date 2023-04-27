resource "azurerm_resource_group" "sac_nsg_resource_group" {
  name     = "sac-testing-nsg-resource-group"
  location = "East US 2"
}

resource "azurerm_network_security_group" "sac_network_security_group" {
  name                = "sac-testing-network-security-group"
  location            = azurerm_resource_group.sac_nsg_resource_group.location
  resource_group_name = azurerm_resource_group.sac_nsg_resource_group.name
}

