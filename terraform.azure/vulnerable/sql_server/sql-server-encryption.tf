resource "azurerm_mssql_server_transparent_data_encryption" "data-encryption" {
  server_id = azurerm_mssql_server.sac_mssql_server.id      
}

