resource "azurerm_cdn_frontdoor_security_policy" "sac_frontdoor_security_policy" {
  name                     = "sac-testing-fd-security-policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.sac_testing_frontdoor_profile.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.sac_frontdoor_firewall_policy.id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.sac_frontdoor_endpoint.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}