
resource "azurerm_resource_group" "sac_function_resource_group" {
  name     = "sac-testing-function-resource-group"
  location = "East US 2"
}

resource "azurerm_linux_function_app" "sac_linux_function_app" {
  name                          = "sac-linux-function-app"
  resource_group_name           = azurerm_resource_group.sac_function_resource_group.name
  location                      = azurerm_resource_group.sac_function_resource_group.location
  storage_account_name          = azurerm_storage_account.sac_linux_storage_account.name
  storage_uses_managed_identity = true
  service_plan_id               = azurerm_service_plan.sac_function_service_plan.id
  client_certificate_enabled    = false
  client_certificate_mode       = "Optional"
  site_config {
    cors {
      allowed_origins = ["*"]
    }
    minimum_tls_version      = "1.0"
    remote_debugging_enabled = true
    ip_restriction {
      action     = "Allow"
      ip_address = "0.0.0.0/0"
    }
  }
}

resource "azurerm_windows_function_app" "sac_windows_function_app" {
  name                          = "sac-windows-function-app"
  resource_group_name           = azurerm_resource_group.sac_function_resource_group.name
  location                      = azurerm_resource_group.sac_function_resource_group.location
  storage_account_name          = azurerm_storage_account.sac_windows_storage_account.name
  storage_uses_managed_identity = true
  service_plan_id               = azurerm_service_plan.sac_function_service_plan.id
  client_certificate_enabled    = false
  client_certificate_mode       = "Optional"
  site_config {
    cors {
      allowed_origins = ["*"]
    }
    minimum_tls_version      = "1.0"
    remote_debugging_enabled = true
    ip_restriction {
      action     = "Allow"
      ip_address = "0.0.0.0/0"
    }
  }
}
