resource "azurerm_resource_group" "storage_account_resource_group" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "demo-storage-account"
  resource_group_name      = azurerm_resource_group.storage_account_resource_group.name
  location                 = azurerm_resource_group.storage_account_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version = "TLS_1_0"
  allow_nested_items_to_be_public = true
  public_network_access_enabled = true

  blob_properties {
    cors_rule {
      allowed_headers = [""]
      allowed_methods = ["get", "head", "post", "delete"]
      allowed_origins = ["*"]
      exposed_headers = [""]
      max_age_in_seconds = 86404
    }    
  }

  enable_https_traffic_only = false

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action = "deny"
    bypass = ["None"]
    ip_rules =  ["10.0.0.1"]
    virtual_network_rules = [azurerm_virtual_network.example.id]
  }

}

resource "azurerm_storage_account_customer_managed_key" "storage_account_key" {
  storage_account_id = azurerm_storage_account.example.id
  key_vault_id       = azurerm_key_vault.example.id
  key_name                    = "demo-storage-account-key"
  key_version                 = ""
  user_assigned_identity_id   = ""
}

resource "azurerm_storage_encryption_scope" "storage_account_encryption" {
  name               = "demo-storage-account-encryption"
  storage_account_id = azurerm_storage_account.example.id
  source             = "Microsoft.KeyVault"
}