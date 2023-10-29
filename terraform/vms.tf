resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Virtual machines (2 instances)
resource "azurerm_linux_virtual_machine" "wordpress_virtual_machine" {
  count                           = 2
  name                            = "${local.name_prefix}-vm${count.index}"
  location                        = local.region
  resource_group_name             = azurerm_resource_group.resource_group.name
  size                            = local.vm_sizing
  admin_username                  = local.vm_admin_login
  admin_password                  = local.vm_admin_password
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = local.vm_admin_login
    public_key = tls_private_key.ssh.public_key_openssh
  }
}

resource "local_file" "ssh_private_key_file" {
  filename        = local.ssh_private_key_output_path
  content         = tls_private_key.ssh.private_key_pem
  file_permission = "0600"
}