
resource "azurerm_resource_group" "vmss_resource_group" {
  name     = "vmss-resource-group"
  location = "East US"
}

resource "azurerm_linux_virtual_machine_scale_set" "sac_linux_vmss" {
  name                            = "sac-linux"
  resource_group_name             = azurerm_resource_group.vmss_resource_group.name
  location                        = azurerm_resource_group.vmss_resource_group.location
  sku                             = "Standard_A1_v2"
  instances                       = 1
  admin_username                  = "adminuser"
  disable_password_authentication = false
  admin_password                  = "P@55w0rd1234!"
  encryption_at_host_enabled      = false
  upgrade_mode = "Automatic"
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  automatic_instance_repair {
    enabled = false
  }
  automatic_os_upgrade_policy {
    enable_automatic_os_upgrade = false
    disable_automatic_rollback  = true
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  data_disk {
    caching              = "None"
    disk_size_gb         = 3
    lun                  = 20
    storage_account_type = "Standard_LRS"
  }
  network_interface {
    name    = "example"
    primary = true
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.vmss_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
    }
  }
}

resource "azurerm_windows_virtual_machine_scale_set" "sac_windows_vmss" {
  name                       = "sac-windo"
  resource_group_name        = azurerm_resource_group.vmss_resource_group.name
  location                   = azurerm_resource_group.vmss_resource_group.location
  sku                        = "Standard_A1_v2"
  instances                  = 1
  admin_username             = "adminuser"
  admin_password             = "P@55w0rd1234!"
  encryption_at_host_enabled = false
  upgrade_mode = "Automatic"
  automatic_instance_repair {
    enabled = false
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  enable_automatic_updates = false
  automatic_os_upgrade_policy {
    enable_automatic_os_upgrade = false
    disable_automatic_rollback  = false
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  data_disk {
    caching              = "None"
    disk_size_gb         = 3
    lun                  = 20
    storage_account_type = "Standard_LRS"
  }
  network_interface {
    name    = "example"
    primary = true
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.vmss_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
    }
  }
  winrm_listener {
    protocol = "Http"
  }
}
