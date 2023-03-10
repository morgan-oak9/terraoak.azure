resource "azurerm_public_ip" "public-ip" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load-balancer" {
  name                = "TestLoadBalancer"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "testing_public_ip"
    # DEMO - severity change based on business impact Low -> High
    zones = ["US East 2"]
    private_ip_address = "testing_private_ip"
    sku_name = "standard"
  }

  tags = {
    "key" = "value"
  } 
}

# DEMO - severity change based on business impact Low -> Moderate
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.example.id
  name            = "ssh-running-probe"
  port            = 22
  protocol = "https"
}