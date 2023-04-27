resource "azurerm_resource_group" "load_balancer_resource_group" {
  name     = "demo-resource-group"
  location = "West Europe"
}

resource "azurerm_public_ip" "load_balancer_public_ip" {
  name                = "demo-load-balancer-ip"
  location            = azurerm_resource_group.load_balancer_resource_group.location
  resource_group_name = azurerm_resource_group.load_balancer_resource_group.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load_balancer" {
  name                = "demo-load-balancer"
  location            = azurerm_resource_group.load_balancer_resource_group.location
  resource_group_name = azurerm_resource_group.load_balancer_resource_group.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.load_balancer_public_ip.id
    sku_name = "basic"
  }
}