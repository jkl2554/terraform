resource "azurerm_resource_group" "vnet3_rg" {
  name     = "vnet3_rg"
  location = "Korea Central"
}

resource "azurerm_virtual_network" "vnet3" {
  name                = "vnet3"
  location            = azurerm_resource_group.vnet3_rg.location
  resource_group_name = azurerm_resource_group.vnet3_rg.name
  address_space       = ["10.3.0.0/16"]
}

resource "azurerm_subnet" "vnet3_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.vnet3_rg.name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes     = ["10.3.1.0/24"]
}

resource "azurerm_public_ip" "vnet3gw_pip" {
  name                = "vnet3gw-pip"
  location            = azurerm_resource_group.vnet3_rg.location
  resource_group_name = azurerm_resource_group.vnet3_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnet3gw" {
  name                = "vnet3gw"
  location            = azurerm_resource_group.vnet3_rg.location
  resource_group_name = azurerm_resource_group.vnet3_rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"
  enable_bgp    = true
 bgp_settings{
    asn = 65003
  }

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.vnet3gw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vnet3_gateway.id
  }
}
