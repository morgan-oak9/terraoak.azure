resource "azurerm_mssql_server_extended_auditing_policy" "sac_mssql_server_auditing_policy" {
  server_id = azurerm_mssql_server.sac_mssql_server.id  
  enabled = false
  retention_in_days = 90
}