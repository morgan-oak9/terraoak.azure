resource "azurerm_mssql_elasticpool" "elasticpool" {
  name = "test-epool"   
  resource_group_name = azurerm_resource_group.server_resource_group.name 
  location = azurerm_resource_group.server_resource_group.location   
  server_name = azurerm_mssql_server.sac_mssql_server.name    
  max_size_gb = 10
  # DEMO - violation based on business impact Low -> High 
  zone_redundant = false

  tags = {
    key = "value"
  }

  sku {     
    name     = "BC_Gen5"  
    tier     = "BusinessCritical"  
    family   = "Gen5"
    capacity = 4    
  }

  per_database_settings {   
    min_capacity = 0     
    max_capacity = 4    
  }
}