output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "web_vm_public_ip" {
  value = azurerm_public_ip.web_pip
}