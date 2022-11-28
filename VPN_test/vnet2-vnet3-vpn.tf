resource "azurerm_virtual_network_gateway_connection" "vnet2_to_vnet3" {
  name                = "vnet2-to-vnet3"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vnet2gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet3gw.id

  shared_key = "hyugoconn23"
  enable_bgp = true
  depends_on = [azurerm_virtual_network_gateway_connection.vnet2_to_vnet3]
}

resource "azurerm_virtual_network_gateway_connection" "vnet3_to_vnet2" {
  name                = "vnet3-to-vnet2"
  location            = azurerm_resource_group.vnet3_rg.location
  resource_group_name = azurerm_resource_group.vnet3_rg.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vnet3gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet2gw.id

  shared_key = "hyugoconn23"
  enable_bgp = true
}
