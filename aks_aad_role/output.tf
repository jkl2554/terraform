resource "local_file" "kubeconfig" {
    content     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
    filename = "${path.root}/kubeconfig"
}
output "id"{
    value = azurerm_kubernetes_cluster.aks_cluster.id
}
output "sp_id"{
    value = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}
output "tenant_id"{
    value = azurerm_kubernetes_cluster.aks_cluster.identity[0].tenant_id
}
output "kubeconfig_dir"{
    value = local_file.kubeconfig.filename
}