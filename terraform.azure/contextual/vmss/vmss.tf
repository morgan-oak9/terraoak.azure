resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_windows_virtual_machine_scale_set" "vmss_windows" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_F2"
  # DEMO - severity change based on business impact Low -> Moderate
  #health_probe_id = ""
  instances           = 1
  admin_password      = "P@55w0rd1234!"
  admin_username      = "adminuser"
  encryption_at_host_enabled = true
  enable_automatic_updates = true
  # DEMO - severity change based on business impact Low -> High
  #zones = [ "test" ]  
  
  automatic_instance_repair {
    enabled = false
  }

  automatic_os_upgrade_policy {
    enable_automatic_os_upgrade = true
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core"
    version   = "latest"
  }

  winrm_listener {
    certificertificate_url = "test-url"
    protocol = "https"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_encryption_set_id = "test-encrypt-id"
  }

  data_disk {
    caching = "None"
    disk_size_gb = 3
    lun = 1234321
    storage_account_type = "Standard_LRS"
    disk_encryption_set_id = "test-disk-id"
    
  }

  network_interface {
    name    = "example"
    primary = true
    network_security_group_id = "network_Security_id"

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = "subnet-id"
    }
  }
}


resource "azurerm_linux_virtual_machine_scale_set" "vmss_linux" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_password      = "P@55w0rd1234!"
  admin_username      = "adminuser"
  encryption_at_host_enabled = true

  # DEMO - severity change based on business impact Low -> High
  #zones = [ "" ]

  automatic_instance_repair {
    enabled = true
  }

  automatic_os_upgrade_policy {
    enable_automatic_os_upgrade = true
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_encryption_set_id = "disk-id-encrypt"
  }

  data_disk {
    caching = "None"
    disk_size_gb = 3
    lun = 1234321
    storage_account_type = "Standard_LRS"
    disk_encryption_set_id = "disk-encrypt-set-id"
    
  }

  network_interface {
    name    = "example"
    primary = true
    network_security_group_id = "test_network_group"

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = "test-subnet-id"

    }
  }
  tags = {
    environment = "staging"
  }
}
