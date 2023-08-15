
resource "azurerm_resource_group" "sac_key_vault_group" {
  name     = "sac-key-vault-group"
  location = "East US 2"
}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "sac_key_vault" {
  name                          = "sac-key-vault"
  location                      = azurerm_resource_group.sac_key_vault_group.location
  resource_group_name           = azurerm_resource_group.sac_key_vault_group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  enable_rbac_authorization     = false
  soft_delete_retention_days    = 90
  public_network_access_enabled = true
  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }
  access_policy {
    tenant_id               = data.azurerm_client_config.current.tenant_id
    object_id               = ""
    key_permissions         = ["Delete", "Purge", "Create", "Get", "Update"]
    secret_permissions      = ["Delete", "Purge", "Get", "Set", "List"]
    certificate_permissions = ["Delete", "DeleteIssuers", "Purge", "Create", "Get", "Update"]
  }
}

resource "azurerm_key_vault_key" "sac_key_vault_key" {
  name         = "sac-key-vault-key"
  key_vault_id = azurerm_key_vault.sac_key_vault.id
  key_type     = "EC"
  key_opts = ["sign", "verify"]
}

resource "azurerm_key_vault_secret" "sac_key_vault_secret" {
  name         = "sac-key-vault-secret-szechuan"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.sac_key_vault.id
}
