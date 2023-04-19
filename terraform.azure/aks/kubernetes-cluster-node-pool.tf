resource "azurerm_kubernetes_cluster_node_pool" "sac_aks_node_pool" {
  name                  = "sacakspool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.sac_aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  enable_node_public_ip = true
  enable_auto_scaling = false
  max_count = 100
  min_count = 0
}