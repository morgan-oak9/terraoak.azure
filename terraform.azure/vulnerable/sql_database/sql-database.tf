resource "azurerm_resource_group" "mssql_database_resource_group" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_mssql_database" "sac_mssql_database" {
  name           = "sac-mssql-database"     # Required
  server_id      = azurerm_mssql_server.mssql_database_server.id    # Required
  zone_redundant = false
  transparent_data_encryption_enabled = false
  sku_name = "DW100c"
}