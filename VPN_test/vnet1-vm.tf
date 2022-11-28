resource "azurerm_subnet" "vnet1_vm_subnet" {
  name                 = "vm_subnet"
  resource_group_name  = azurerm_resource_group.vnet1_rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_public_ip" "vnet1_vm_pip" {
  name                = "vnet3gw-pip"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vnet1_vm" {
  name                = "vnet1vm-nic"
  location            = azurerm_resource_group.vnet1_rg.location
  resource_group_name = azurerm_resource_group.vnet1_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet1_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vnet1_vm_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vnet1_vm" {
  name                = "vnet1vm"
  resource_group_name = azurerm_resource_group.vnet1_rg.name
  location            = azurerm_resource_group.vnet1_rg.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.vnet1_vm.id,
  ]
  disable_password_authentication = false
  admin_password = "qwer1234!@#$"
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}