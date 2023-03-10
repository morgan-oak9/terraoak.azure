resource "azurerm_resource_group" "server_resource_group" {
  name     = "sql-server-resource-group"
  location = "East US 2"
}

resource "azurerm_mssql_server" "sac_mssql_server" {
  name = "sac-testing-mssql-server"  # Required
  resource_group_name = azurerm_resource_group.server_resource_group.name   # Required
  location = azurerm_resource_group.server_resource_group.location  # Required
  version = "12.0"  # Required
  administrator_login = "msuch-oak9"  # Required
  administrator_login_password = "$uPer$ecure$ecret!234"  # Required
  minimum_tls_version = "1.2"
  public_network_access_enabled = false

  tags = {
    environment = "production"
  }
}