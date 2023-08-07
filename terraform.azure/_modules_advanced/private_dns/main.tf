
resource "azurerm_resource_group" "private_dns_zone_rg" {
  name     = "private-dns-resource-group"
  location = "East US 2"
}

resource "azurerm_private_dns_zone" "sac_private_dns_zone" {
  name                = "testingdomain.com"
  resource_group_name = azurerm_resource_group.private_dns_zone_rg.name
}