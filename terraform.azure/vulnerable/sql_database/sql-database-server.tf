resource "azurerm_mssql_server" "mssql_database_server" {
  name = "sac-testing-mssql-server"  
  resource_group_name = azurerm_resource_group.mssql_database_resource_group.name   
  location = azurerm_resource_group.mssql_database_resource_group.location  
  version = "12.0"  
  administrator_login = "admin-testing"  
  administrator_login_password = "$uPer$ecure$ecret!234"  
  minimum_tls_version          = "1.1"
  public_network_access_enabled = true
}