terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {

  }
}
resource "azurerm_resource_group" "main" {
  name     = "rg-network-project"
  location = var.location
  tags = {
    environment = "dev"
    project     = "azure-network-project"
  }
}
resource "azurerm_virtual_network" "main" {
  name                = "Project_vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_space
  tags = {
    environment = "dev"
    owner       = "your-name"
  }
}
resource "azurerm_subnet" "main" {
  name                 = "Project_subnet"
  address_prefixes     = var.subnet_prefix
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
}
resource "azurerm_subnet" "second" {
  name                 = "Project_subnet_2"
  address_prefixes     = ["10.0.2.0/24"]
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
}
resource "azurerm_subnet" "third" {
  name                 = "Project_subnet_3"
  address_prefixes     = ["10.0.3.0/24"]
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
}
resource "azurerm_subnet" "fourth" {
  name                 = "Project_subnet_4"
  address_prefixes     = ["10.0.4.0/24"]
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
}
resource "azurerm_subnet" "fifth" {
  name                 = "Project_subnet_5"
  address_prefixes     = ["10.0.5.0/24"]
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
}
resource "azurerm_network_security_group" "main" {
  location            = azurerm_resource_group.main.location
  name                = "Project_NSG"
  resource_group_name = azurerm_resource_group.main.name
}
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}
resource "azurerm_network_security_rule" "main" {
  resource_group_name         = azurerm_resource_group.main.name
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "Project_NSG_Rule"
  network_security_group_name = azurerm_network_security_group.main.name
  priority                    = 100
  protocol                    = "Tcp"
  source_address_prefix       = "103.123.173.106"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
}
resource "azurerm_public_ip" "main" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.main.location
  name                = "project_Public_IP"
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
}
resource "azurerm_network_interface" "main" {
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  name                = "Project_Network_Interface"
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}
resource "azurerm_linux_virtual_machine" "main" {
  name                = "Linux-machine"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  admin_ssh_key {
    username   = var.adminuser
    public_key = file("C:/Users/shoeb.arshad/.ssh/azure_vm_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}