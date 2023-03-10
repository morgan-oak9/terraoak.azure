resource "azurerm_api_management_named_value" "sac_api_management_named_val" {
  name = "sac-testing-apim-named-value"   
  resource_group_name = azurerm_resource_group.apim_resource_group.name   
  api_management_name = azurerm_api_management.sac_api_management.name   
  display_name = "ExampleProperty"    
  secret = true   # Must be true to trigger validation

  tags = ["test-tag"]

  value_from_key_vault {
    secret_id = "top_secret_secret_id"  
    identity_client_id = "identity_client_id"   
  }
}