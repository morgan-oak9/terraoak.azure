
resource "azurerm_resource_group" "cosmos_db_resource_group" {
  name     = "cosmos-db-rg"
  location = "East US 2"
}

resource "azurerm_cosmosdb_account" "sac_cosmosdb_account" {
  name                = "sac-testing-cosmosdb"
  resource_group_name = azurerm_resource_group.cosmos_db_resource_group.name
  location            = azurerm_resource_group.cosmos_db_resource_group.location
  kind = "GlobalDocumentDB"
  offer_type          = "Standard"
  is_virtual_network_filter_enabled = true
  enable_automatic_failover = false
  analytical_storage_enabled = true
  public_network_access_enabled = true
  ip_range_filter = "0.0.0.0,203.0.113.0/16"
  consistency_policy {
    consistency_level = "Strong"
  }
  geo_location {
    location          = "East US 2"
    failover_priority = 0
  }
  cors_rule {
    allowed_methods = ["GET", "DELETE"]
    allowed_origins = ["*"]
    # oak9: CORS configuration should only allow requests from trusted origins
    allowed_headers = ["*"]
    exposed_headers = ["*"]
    max_age_in_seconds = 100
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmos_db_sql_db" {
  name                = "cosmos-db-sql"
  resource_group_name = azurerm_resource_group.cosmos_db_resource_group.name
  account_name        = azurerm_cosmosdb_account.sac_cosmosdb_account.name
  throughput          = 400
}

resource "azurerm_cosmosdb_sql_container" "cosmos_db_sql_container" {
  name                   = "cosmos-db-sqlcont"
  resource_group_name    = azurerm_resource_group.cosmos_db_resource_group.name
  account_name           = azurerm_cosmosdb_account.sac_cosmosdb_account.name
  database_name          = azurerm_cosmosdb_sql_database.cosmos_db_sql_db.name
  partition_key_path     = "/definition/id"
  partition_key_version  = 1
  throughput             = 400
  analytical_storage_ttl = -1
  indexing_policy {
    indexing_mode = "consistent"
    included_path {
      path = "/*"
    }
    included_path {
      path = "/included/?"
    }
    excluded_path {
      path = "/excluded/?"
    }
  }
  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
