resource "azurerm_mssql_elasticpool" "elasticpool" {
  name = "test-epool"   # Required
  resource_group_name = azurerm_resource_group.server_resource_group.name # Required
  location = azurerm_resource_group.server_resource_group.location   # Required
  server_name = azurerm_mssql_server.sac_mssql_server.name    # Required
  max_size_gb = 10
  zone_redundant = false

  sku {     # Required
    name     = "BC_Gen5"  # Required
    tier     = "BusinessCritical"  # Required
    family   = "Gen5"
    capacity = 4    # Required
  }

  per_database_settings {   # Required
    min_capacity = 0     # Required
    max_capacity = 4    # Required
  }
}