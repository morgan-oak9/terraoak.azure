
resource "azurerm_resource_group" "app_gateway_resource_group" {
  name     = "sac-app-gateway-group"
  location = "East US 2"
}

resource "azurerm_application_gateway" "sac_application_gateway" {
  name                = "sac-application-gateway"
  resource_group_name = azurerm_resource_group.app_gateway_resource_group.name
  location            = azurerm_resource_group.app_gateway_resource_group.location
  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 1
  }
  frontend_ip_configuration {
    name                 = "frontend-ip-config"
  }
  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 63
    protocol              = "Https"
    request_timeout       = 0
    connection_draining {
      enabled = false
      drain_timeout_sec = 4000
    }
  }
  http_listener {
    name                           = "http-listener-1"
    frontend_ip_configuration_name = "ip_config_1"
    frontend_port_name             = "front_end_port_1"
    protocol                       = "Https"
    port                           = 443
  }
  ssl_policy {
    policy_type = "Predefined"
    min_protocol_version = "TLSv1_1"
    policy_name = "AppGwSslPolicy20150501"
  }
  ssl_certificate {
    name = "demo-ssl-certificate"
  }
}

resource "azurerm_public_ip" "app_gateway_ip_config" {
  name                = "demo-app-gateway-ipconfig"
  resource_group_name = azurerm_resource_group.app_gateway_resource_group.name
  location            = azurerm_resource_group.app_gateway_resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["us-east-1", "us-west-1", "us-west-2"]
}

resource "azurerm_key_vault" "app_gateway_vault" {
  name                        = "sac-app-gateway-vault"
  location                    = azurerm_resource_group.app_gateway_resource_group.location
  resource_group_name         = azurerm_resource_group.app_gateway_resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
}