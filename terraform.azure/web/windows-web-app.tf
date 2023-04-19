resource "azurerm_windows_web_app" "sac_windows_web_app" {
  name                = "sac-windows-web-app"
  resource_group_name = azurerm_resource_group.sac_web_resource_group.name
  location            = azurerm_resource_group.sac_web_resource_group.location
  service_plan_id            = azurerm_service_plan.sac_web_service_plan.id
  client_certificate_enabled = false
  client_certificate_mode = "Optional"

  site_config {
    cors {
      allowed_origins = ["*"]
    }
    minimum_tls_version = "1.0"
    remote_debugging_enabled = true

    ip_restriction {
        action = "Allow"
        ip_address = "0.0.0.0/0"
    }
  }
}
