resource "azurerm_resource_group" "front_door_rg" {
  name     = "sac-cdn-front-door-resource-group"
  location = "East US 2"
}

resource "azurerm_cdn_frontdoor_profile" "sac_testing_frontdoor_profile" {
  name                = "sac-frontdoor-cdn-profile"
  resource_group_name = azurerm_resource_group.front_door_rg.name
  sku_name            = "Premium_AzureFrontDoor"
}