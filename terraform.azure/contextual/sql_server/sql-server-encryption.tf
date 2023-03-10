resource "azurerm_mssql_server_transparent_data_encryption" "data-encryption" {
  server_id = azurerm_mssql_server.sac_mssql_server.id      

  # DEMO - violation based on data sensitivity 
  #key_vault_key_id = azurerm_key_vault_key.example.id
}

