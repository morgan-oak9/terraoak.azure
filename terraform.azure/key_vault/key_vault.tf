resource "azurerm_resource_group" "key_vault_resource_group" {
  name     = "demo-resource-group"
  location = "West Europe"
}

resource "azurerm_key_vault" "key_vault" {
  name                              = "demo-key-vault"
  location                          = azurerm_resource_group.key_vault_resource_group.location
  resource_group_name               = azurerm_resource_group.key_vault_resource_group.name
  sku_name                          = "standard"
  enabled_for_disk_encryption       = true
  purge_protection_enabled          = true
  enabled_for_template_deployment   = true
  enable_rbac_authorization         = false
  soft_delete_retention_days        = 90
  enabled_for_deployment            = true
  public_network_access_enabled = true

  network_acls {
    bypass          = "None"
    default_action  =  "allow"
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    azure_ad_user_principal_names       = ["foo1@example.com", "foo2@example.com"]
    key_permissions                     = ["delete"]
    secret_permissions                  = ["purge"]
    certificate_permissions             = ["purge"]
  }
}

resource "azurerm_key_vault_key" "key_vault_key" {
  name              = "demo-key-vault-key"
  key_vault_id      = azurerm_key_vault.key_vault.id
  key_size          = 2048
  key_type          = "EC"
  key_opts = ["sign"]

}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = "demo-key-vault-secret"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.key_vault.id
}