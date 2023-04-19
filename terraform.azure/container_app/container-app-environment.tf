resource "azurerm_container_app_environment" "sac_container_app_env" {
  name                       = "sac-testing-container-env"
  location                   = azurerm_resource_group.container_app_resource_group.location
  resource_group_name        = azurerm_resource_group.container_app_resource_group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.sac_container_app_workspace.id
}

resource "azurerm_log_analytics_workspace" "sac_container_app_workspace" {
  name                = "sac-testing-app-workspace"
  location            = azurerm_resource_group.container_app_resource_group.location
  resource_group_name = azurerm_resource_group.container_app_resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}