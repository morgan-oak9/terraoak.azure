
resource "azurerm_resource_group" "apim_resource_group" {
  name     = "apim-resource-group"
  location = "East US 2"
}

resource "azurerm_api_management" "sac_api_management" {
  name                       = "sac-testing-api-management"
  location                   = azurerm_resource_group.apim_resource_group.location
  resource_group_name        = azurerm_resource_group.apim_resource_group.name
  publisher_name             = "My Company"
  publisher_email            = "company@terraform.io"
  sku_name                   = "Premium_1"
  client_certificate_enabled = false
  public_network_access_enabled = false
  virtual_network_configuration {
    subnet_id = azurerm_subnet.sac_apim_subnet.id
  }
}

resource "azurerm_api_management_api" "sac_api_management_api" {
  name                = "sac-testing-apim-api"
  resource_group_name = azurerm_resource_group.apim_resource_group.name
  api_management_name = azurerm_api_management.sac_api_management.name
  revision            = "1"
  display_name        = "ac-testing-apim-api"
  protocols           = ["http"]
}

resource "azurerm_api_management_backend" "sac_api_management_backend" {
  name                = "sac-testing-apim-backend"
  resource_group_name = azurerm_resource_group.apim_resource_group.name
  api_management_name = azurerm_api_management.sac_api_management.name
  protocol            = "http"
  url                 = "https://conferenceapi.azurewebsites.net?format=json"
  tls {
    validate_certificate_chain = false
    validate_certificate_name  = false
  }
}

resource "azurerm_api_management_named_value" "sac_api_management_named_val" {
  name                = "sac-testing-apim-named-value"
  resource_group_name = azurerm_resource_group.apim_resource_group.name
  api_management_name = azurerm_api_management.sac_api_management.name
  display_name        = "ExampleProperty"
  secret              = true
  value               = "Example Value"
  tags                = ["test-tag"]
}
