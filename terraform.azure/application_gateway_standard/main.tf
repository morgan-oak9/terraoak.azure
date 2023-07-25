

# ---------------------------------------------------------------------
# Application Gateway
# ---------------------------------------------------------------------
resource "azurerm_application_gateway" "sac_application_gateway" {
  name                = "sac-application-gateway-standard"
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
    protocol              = "http"
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
    protocol                       = "HTTP"
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