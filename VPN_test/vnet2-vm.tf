resource "azurerm_subnet" "vnet2_vm_subnet" {
  name                 = "vm_subnet"
  resource_group_name  = azurerm_resource_group.vnet2_rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.2.0.0/24"]
}

resource "azurerm_network_interface" "vnet2_vm" {
  name                = "vnet2vm-nic"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet2_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vnet2_vm" {
  name                = "vnet2vm"
  resource_group_name = azurerm_resource_group.vnet2_rg.name
  location            = azurerm_resource_group.vnet2_rg.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.vnet2_vm.id,
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