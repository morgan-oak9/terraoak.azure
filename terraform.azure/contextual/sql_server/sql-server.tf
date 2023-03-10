resource "azurerm_resource_group" "server_resource_group" {
  name     = "sql-server-resource-group"
  location = "East US 2"
}

resource "azurerm_mssql_server" "sac_mssql_server" {
  name = "sac-testing-mssql-server"  
  resource_group_name = azurerm_resource_group.server_resource_group.name   
  location = azurerm_resource_group.server_resource_group.location  
  version = "12.0"  
  administrator_login = "msuch-oak9"  
  administrator_login_password = "$uPer$ecure$ecret!234"  
  minimum_tls_version = "1.2"
  public_network_access_enabled = false

  tags = {
    environment = "production"
  }
}