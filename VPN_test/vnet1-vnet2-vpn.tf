resource "azurerm_virtual_network_gateway_connection" "vnet1_to_vnet2" {
  name                = "vnet1-to-vnet2"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vnet1gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet2gw.id

  shared_key = "hyugoconn12"
  enable_bgp = true
}

resource "azurerm_virtual_network_gateway_connection" "vnet2_to_vnet1" {
  name                = "vnet2-to-vnet1"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vnet2gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnet1gw.id

  shared_key = "hyugoconn12"
  enable_bgp = true
}
