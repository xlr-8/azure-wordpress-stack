
output "vm_informations" {
  value = [
    for vm in azurerm_linux_virtual_machine.wordpress_virtual_machine :
    {
      name       = vm.name
      ip_address = vm.public_ip_address
      id         = vm.id
    }
  ]
}
