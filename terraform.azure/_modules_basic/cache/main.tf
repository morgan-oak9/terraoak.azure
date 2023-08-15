
resource "azurerm_resource_group" "cache_resource_group" {
  name     = "cache-resource-group"
  location = "East US 2"
}

resource "azurerm_redis_cache" "sac_redis_cache" {
  name                = "sac-cache"
  location            = azurerm_resource_group.cache_resource_group.location
  resource_group_name = azurerm_resource_group.cache_resource_group.name
  capacity            = 1
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = true
  minimum_tls_version = "1.0"
  public_network_access_enabled = true
  redis_configuration {
    rdb_backup_enabled            = false
    rdb_backup_frequency          = 60
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.sac_cache_storage.primary_blob_endpoint};AccountName=${azurerm_storage_account.sac_cache_storage.name};AccountKey=${azurerm_storage_account.sac_cache_storage.primary_access_key}"
  }
}
