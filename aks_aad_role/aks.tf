resource "azurerm_resource_group" "aks_cluster_rg"{
  name = var.rg_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks_cluster_rg.location
  resource_group_name = azurerm_resource_group.aks_cluster_rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_rg_name
  local_account_disabled  = "true"

  default_node_pool {
    name                = "default"
    enable_auto_scaling = "true"
    min_count           = var.min_node_cout
    max_count           = var.max_node_count
    node_count          = var.node_count
    max_pods            = var.max_pods

    vm_size = var.vm_size
  }
  identity {
    type = "SystemAssigned"
  }
  sku_tier = var.sku_tier
  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = var.dns_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr       = var.service_cidr
  }
  azure_active_directory_role_based_access_control {
    managed                = "true"
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = "true"
  }
  key_vault_secrets_provider {
    secret_rotation_enabled = "true"
    secret_rotation_interval = "5m"
  }

}

