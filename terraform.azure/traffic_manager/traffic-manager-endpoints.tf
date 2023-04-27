resource "azurerm_public_ip" "traffic_manager_ip" {
  name                = "sac-traffic-manager-public-ip"
  location            = azurerm_resource_group.sac_traffic_manager_group.location
  resource_group_name = azurerm_resource_group.sac_traffic_manager_group.name
  allocation_method   = "Static"
  domain_name_label   = "sac-traffic-manager-public-ip"
}

resource "azurerm_traffic_manager_azure_endpoint" "azure_endpoint" {
  name               = "sac-azure-endpoint"
  profile_id         = azurerm_traffic_manager_profile.sac_traffic_manager_profiles.id
  target_resource_id = azurerm_public_ip.traffic_manager_ip.id
}

resource "azurerm_traffic_manager_external_endpoint" "external_endpoint" {
  name       = "sac-external-endpoint"
  profile_id = azurerm_traffic_manager_profile.sac_traffic_manager_profiles.id
  target     = "acorncorp.com"
}

resource "azurerm_traffic_manager_nested_endpoint" "nested_endpoint" {
  name                    = "sac-nested-endpoint"
  target_resource_id      = azurerm_linux_web_app.app_service.id
  profile_id              = azurerm_traffic_manager_profile.sac_traffic_manager_profiles.id
  minimum_child_endpoints = 2
}

resource "azurerm_service_plan" "nested_plan" {
  name                = "sac-app-service-plan"
  resource_group_name = azurerm_resource_group.sac_traffic_manager_group.name
  location            = azurerm_resource_group.sac_traffic_manager_group.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "sac-nested-app-service"
  resource_group_name = azurerm_resource_group.sac_traffic_manager_group.name
  location            = azurerm_service_plan.nested_plan.location
  service_plan_id     = azurerm_service_plan.nested_plan.id

  site_config {}
}