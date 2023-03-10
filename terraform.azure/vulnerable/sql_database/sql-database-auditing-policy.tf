# SaC Testing - Severity: Critical - Set auditing policy to undefined
resource "azurerm_mssql_database_extended_auditing_policy" "mssql_database_auditing_policy" {
  database_id = azurerm_mssql_database.sac_mssql_database.id   # Required
  enabled = false
  retention_in_days = 10
}