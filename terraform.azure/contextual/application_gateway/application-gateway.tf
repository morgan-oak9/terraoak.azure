resource "azurerm_application_gateway" "sac_application_gateway" {
  name                = "example-appgateway"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  fips_enabled = true
  
  sku {
    name     = "Standard_v2"
    tier     = "WAF_v2"
    capacity = 4
  }

  autoscale_configuration {
    min_capacity = 5
    max_capacity = 5
  }

  custom_error_configuration {
    status_code = "1234"
    custom_error_page_url = "error"
  }

  gateway_ip_configuration {
    name      = "test"
    subnet_id = "1234"
  }

  waf_configuration {
   enabled = true
   file_upload_limit_mb = 1000
   request_body_check = true
   max_request_body_size_kb = 100

   disabled_rule_group {
     rule_group_name = "test"
     rules = [1, 2, 3]
   }

   exclusion {
     match_variable = "test"
     selector = "test"
     selector_match_operator = "test"
   }

   firewall_mode = "DETECTION"
   rule_set_version = "0.1"

  }

  frontend_port {
    name = "test"
    port = 443
  }

  # Required
  frontend_ip_configuration {
    name                 = "test"
    private_ip_address = "test"
    private_ip_address_allocation = "test"
    public_ip_address_id = "1234"
    subnet_id = "4321"
  }
  
  # Required
  backend_address_pool {
    name = "test"
    fqdns = ["test"]
    ip_addresses = ["test"]
  }

  # Required
  backend_http_settings {
    name                  = "test"
    cookie_based_affinity = "Enabled"
    affinity_cookie_name = "test"
    port                  = 80
    protocol              = "https"
    request_timeout       = 30
    
    connection_draining {
      # DEMO - violation based on business impact
      enabled = false
      drain_timeout_sec = 3000
    }

    trusted_root_certificate{
      name = "test"
      data = "1234"
    }

    authentication_certificate {
      name = "test"
    }
    trusted_root_certificate_names = [""]
  }

  authentication_certificate {
    name = "test"
    data = "1234"
  }

  trusted_root_certificate {
    name = "test"
    data = "test"
    key_vault_secret_id  = "1234"
  }

  http_listener {
    name                           = "test1"
    frontend_ip_configuration_name = "ip_config_1"
    frontend_port_name             = "front_end_port_1"
    protocol                       = "HTTPS"
    port                           = 443
  }

  http_listener {
    name                           = "test2"
    frontend_ip_configuration_name = "ip_config_2"
    frontend_port_name             = "front_end_port_2"
    host_name = "test"
    protocol                       = "HTTPS"
    port                           = 445
  }

  # Required
  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority = 2
  }

  probe {
    interval = 10
    name = "test"
    host = "test"
    protocol = "https"

    match {
      body = "test"
      status_code = ["1234"]
    }

    minimum_servers = 2
    path = "/test/path"
    pick_host_name_from_backend_http_settings = true
    timeout = 60
    unhealthy_threshold = 40
    port = 98
  }

  # DEMO - severity change based on business impact Low -> Moderate
  #zones = ["test"]

  ssl_policy {
    policy_type = "custom"
    policy_name = "test"
    cipher_suites = ["TLS_DHE_RSA_WITH_AES_256_GCM_SHA384"]
    min_protocol_version = "tlsv1_2"
    disabled_protocols = ["TLSv1_1"]
  }

  ssl_certificate {
    name = "test-cert"
    key_vault_secret_id = "1234"
    password = "4321"
  }

  tags = {
    "key" = "value"
    "key1" = "value1"
  }
}