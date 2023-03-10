resource "azurerm_api_management_api" "sac_api_management_api" {
  name = "sac-testing-apim-api"   
  resource_group_name = azurerm_resource_group.apim_resource_group.name   
  api_management_name = azurerm_api_management.sac_api_management.name   
  revision = "1"  
  display_name = "ac-testing-apim-api"
  protocols = ["https"]
}