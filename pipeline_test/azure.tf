# main.tf

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "legal_support_platform_rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "example" {
  name                = "legal_support_platform_plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "legal-support-platform"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v5.0"
    always_on                = true
  }

  app_settings = {
    "WEBSITE_DOTNET_FRAMEWORK_VERSION" = "v5.0"
  }
}

resource "azurerm_sql_server" "example" {
  name                         = "legalsupportplatformdb"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "P@ssw0rd1234!"
}

resource "azurerm_sql_database" "example" {
  name                = "casesdb"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  edition             = "Standard"
  compute_model       = "GeneralPurpose"
  sku_name            = "S0"
}

resource "azurerm_storage_account" "example" {
  name                     = "legalsupportplatformstorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "documents"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
