terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myResourceGroup" {
  name     = "${var.name}-resource-group"
  location = var.location
}

resource "azurerm_virtual_network" "myVirtualNetwork" {
  name                = "${var.name}-network"
  address_space       = var.address_space
  location            = azurerm_resource_group.myResourceGroup.location
  resource_group_name = azurerm_resource_group.myResourceGroup.name
}

resource "azurerm_subnet" "mySubnet" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.myResourceGroup.name
  virtual_network_name = azurerm_virtual_network.myVirtualNetwork.name
  address_prefixes     = var.address_prefix
}

resource "azurerm_network_interface" "myNetworkInterface" {
  name                = "${var.name}-interface"
  location            = azurerm_resource_group.myResourceGroup.location
  resource_group_name = azurerm_resource_group.myResourceGroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "myVM" {
  name                  = "${var.name}-vm"
  location              = azurerm_resource_group.myResourceGroup.location
  resource_group_name   = azurerm_resource_group.myResourceGroup.name
  network_interface_ids = [azurerm_network_interface.myNetworkInterface.id]
  vm_size               = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

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