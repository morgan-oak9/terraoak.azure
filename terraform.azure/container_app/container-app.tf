resource "azurerm_resource_group" "container_app_resource_group" {
  name     = "container-resource-group"
  location = "East US 2"
}

resource "azurerm_container_app" "sac_container_app" {
  name                         = "sac-testing-container-app"
  container_app_environment_id = azurerm_container_app_environment.sac_container_app_env.id
  resource_group_name          = azurerm_resource_group.container_app_resource_group.name
  revision_mode                = "Single"
  
  ingress{
    allow_insecure_connections = true
    transport = "auto"
    target_port = 6784

    traffic_weight{
        percentage = 100
    }
  }

  template {
    container {
      name   = "sactestingcontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}