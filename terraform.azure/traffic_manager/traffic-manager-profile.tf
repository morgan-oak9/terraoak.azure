resource "azurerm_resource_group" "sac_traffic_manager_group" {
  name     = "sac-traffic-resource-group"
  location = "East US"
}

resource "azurerm_traffic_manager_profile" "sac_traffic_manager_profiles" {
  name                   = "sac-testing-traffic-manager"
  resource_group_name    = azurerm_resource_group.sac_traffic_manager_group.name
  traffic_routing_method = "Geographic"
  traffic_view_enabled = false
}