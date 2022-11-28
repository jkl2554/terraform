resource "azurerm_resource_group" "vnet1_rg" {
  name     = "vnet1_rg"
  location = "Korea Central"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "vnet1_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.vnet1_rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_public_ip" "vnet1gw_pip" {
  name                = "vnet1gw-pip"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnet1gw" {
  name                = "vnet1gw"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"
  enable_bgp    = true
  bgp_settings{
    asn = 65001
  }

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.vnet1gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vnet1_gateway.id
  }
}
