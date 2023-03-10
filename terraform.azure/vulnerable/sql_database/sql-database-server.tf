resource "azurerm_mssql_server" "mssql_database_server" {
  name = "sac-testing-mssql-server"  # Required
  resource_group_name = azurerm_resource_group.mssql_database_resource_group.name   # Required
  location = azurerm_resource_group.mssql_database_resource_group.location  # Required
  version = "12.0"  # Required
  administrator_login = "admin-testing"  # Required
  administrator_login_password = "$uPer$ecure$ecret!234"  # Required
  minimum_tls_version          = "1.1"
  public_network_access_enabled = true
}