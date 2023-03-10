resource "azurerm_api_management_named_value" "sac_api_management_named_val" {
  name = "sac-testing-apim-named-value"   # Required
  resource_group_name = azurerm_resource_group.apim_resource_group.name   # Required
  api_management_name = azurerm_api_management.sac_api_management.name   # Required
  display_name = "ExampleProperty"    # Required
  secret = true   # Must be true to trigger validation

  tags = ["test-tag"]

  value_from_key_vault {
    secret_id = "top_secret_secret_id"  # Required
    identity_client_id = "identity_client_id"   # Required
  }
}