output "vm_public_ip" {
  value = azurerm_public_ip.main.ip_address
}
output "vnet_name" {
  value = azurerm_virtual_network.main.name
}