resource "azurerm_virtual_network_gateway_connection" "vnet3_to_vnet1" {
  name                = "vnet3-to-vnet1"
  location            = azurerm_resource_group.vnet3_rg.location
  resource_group_name = azurerm_resource_group.vnet3_rg.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vnet3gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet1gw.id

  shared_key = "hyugoconn31"
  enable_bgp = true
  depends_on = [azurerm_virtual_network_gateway_connection.vnet3_to_vnet2]
}

resource "azurerm_virtual_network_gateway_connection" "vnet1_to_vnet3" {
  name                = "vnet1-to-vnet3"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vnet1gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet3gw.id

  shared_key = "hyugoconn31"
  enable_bgp = true
  depends_on = [azurerm_virtual_network_gateway_connection.vnet1_to_vnet2]
}
