variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "virtual_machine_resource_group" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "virtual_machine_network" {
  name                = "demo-virtual-machine-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.virtual_machine_resource_group.location
  resource_group_name = azurerm_resource_group.virtual_machine_resource_group.name
}

resource "azurerm_subnet" "virtual_machine_subnet" {
  name                 = "demo-virtual-machine-subnet"
  resource_group_name  = azurerm_resource_group.virtual_machine_resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_machine_resource_group.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "virtual_machine_interface" {
  name                = "demo-virtual-machine-interface"
  location            = azurerm_resource_group.virtual_machine_resource_group.location
  resource_group_name = azurerm_resource_group.virtual_machine_resource_group.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.virtual_machine_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  name                = "demo-virtual-machine"
  resource_group_name = azurerm_resource_group.virtual_machine_resource_group.name
  location            = azurerm_resource_group.virtual_machine_resource_group.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.virtual_machine_interface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

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

resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  name                = "demo-windows-virtual-machine"
  resource_group_name = azurerm_resource_group.virtual_machine_resource_group.name
  location            = azurerm_resource_group.virtual_machine_resource_group.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.virtual_machine_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}