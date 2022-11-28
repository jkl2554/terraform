resource "azurerm_resource_group" "vnet2_rg" {
  name     = "vnet2_rg"
  location = "Korea Central"
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "vnet2_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.vnet2_rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_public_ip" "vnet2gw_pip" {
  name                = "vnet2gw-pip"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnet2gw" {
  name                = "vnet2gw"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"
  enable_bgp    = true
  bgp_settings{
    asn = 65002
  }

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.vnet2gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vnet2_gateway.id
  }
}
