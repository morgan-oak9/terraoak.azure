resource "azurerm_resource_group" "aks_resource_group" {
  name     = "aks-demo-resource-group"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-demo-cluster"
  location            = azurerm_resource_group.aks_resource_group.location
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  dns_prefix                        = var.name
  kubernetes_version                = var.kubernetes_version
  api_server_authorized_ip_ranges   = var.api_server_authorized_ip_ranges
  node_resource_group               = var.node_resource_group
  azure_policy_enabled              = false
  role_based_access_control_enabled = false
  private_cluster_enabled = false
  local_account_disabled = false

  load_balancer_profile{
      idle_timeout_in_minutes = 10
  }
  
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    enable_auto_scaling = false
    enable_node_public_ip = true
  }

  service_principal {
    client_id = "example-id"
    client_secret = "SecretText"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "azure"
    docker_bridge_cidr = "172.17.0.1/16"
    
    load_balancer_profile {
      outbound_ip_address_ids = []
    }

  }

  azure_active_directory_role_based_access_control {
    managed = true
    azure_rbac_enabled = false
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "aks_cluster_node_pool" {
  # All options # Must be configured
  name                  = "aks-demo-cluster-node-pool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  enable_node_public_ip = true
  zones = []
  enable_auto_scaling = false
  max_count = 100
  min_count = 0

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_disk_encryption_set" "aks_disk_encryption_set" {
  name                = "aks-demo-cluster-node-pool"
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  location            = azurerm_resource_group.aks_resource_group.location
  key_vault_key_id    = azurerm_key_vault_key.example.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_key" "aks_key" {
  name         = "aks-demo-cluster-node-pool"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048

  depends_on = [
    azurerm_key_vault_access_policy.example-user
  ]

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}