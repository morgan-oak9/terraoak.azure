
resource "azurerm_resource_group" "dns_zone_rg" {
  name     = "dns-resource-group"
  location = "East US 2"
}

resource "azurerm_dns_zone" "sac_dns_zone" {
  name                = "testingdomain.com"
  resource_group_name = azurerm_resource_group.dns_zone_rg.name
}