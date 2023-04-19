resource "azurerm_cdn_frontdoor_endpoint" "sac_frontdoor_endpoint" {
  name                     = "sac-cdn-frontdoor-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.sac_testing_frontdoor_profile.id

  tags = {
    ENV = "testing"
  }
}