resource "azurerm_mssql_server_extended_auditing_policy" "sac_mssql_server_auditing_policy" {
  server_id = azurerm_mssql_server.sac_mssql_server.id  # Required
  enabled = true
  storage_endpoint = azurerm_storage_account.example.primary_blob_endpoint
  log_monitoring_enabled = true
  retention_in_days = 90
}