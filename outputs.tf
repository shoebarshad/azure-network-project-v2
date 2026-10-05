output "vm_public_ip" {
  value = azurerm_public_ip.main.ip_address
}
output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
output "second_subnet_id" {
  value = azurerm_subnet.second.id
}
output "third_subnet_name" {
  value = azurerm_subnet.third.name
}
output "fourth_subnet_name" {
  value = azurerm_subnet.fourth.name
}