
resource "azurerm_resource_group" "sac_vm_group" {
  name     = "sac-vm-group-0"
  location = "East US"
}

resource "azurerm_linux_virtual_machine" "sac_linux_vm" {
  name                            = "sac-testing-linux-vm"
  resource_group_name             = azurerm_resource_group.sac_vm_group.name
  location                        = azurerm_resource_group.sac_vm_group.location
  size                            = "Standard_A1_v2"
  admin_username                  = "adminuser"
  admin_password                  = "$uper$ecretP@$$w0rd"
  secure_boot_enabled             = false
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.sac_vm_network_interface.id,
  ]
  encryption_at_host_enabled = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "sac_windows_vm" {
  name                = "sac-windows-vm"
  resource_group_name = azurerm_resource_group.sac_vm_group.name
  location            = azurerm_resource_group.sac_vm_group.location
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  admin_password      = "$uper$ecretP@$$w0rd"
  secure_boot_enabled = false
  network_interface_ids = [
    azurerm_network_interface.sac_windows_network_interface.id,
  ]
  encryption_at_host_enabled = false
  winrm_listener {
    protocol = "Http"
  }
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
