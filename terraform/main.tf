# Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "${local.name_prefix}-rg"
  location = local.region
}


# Ansible inventory file
resource "local_file" "ansible_inventory_file" {
  filename = local.ansible_inventory_output_path
  content = templatefile(var.ansible_inventory_template_path,
    {
      azure_vm_1_ip            = azurerm_public_ip.public_ip[0].ip_address
      azure_vm_2_ip            = azurerm_public_ip.public_ip[1].ip_address
      db_server_host           = azurerm_mysql_flexible_server.wpdbserver.fqdn
      db_server_admin_username = azurerm_mysql_flexible_server.wpdbserver.administrator_login
      db_server_admin_password = azurerm_mysql_flexible_server.wpdbserver.administrator_password
    }
  )
}


# Ansible configuration file
resource "local_file" "ansible_variables_file" {
  filename = local.ansible_vars_output_path
  content = jsonencode({
    wp_db_name     = azurerm_mysql_flexible_database.db.name
    wp_db_user     = local.mysql_admin_login
    wp_db_password = local.mysql_admin_password
    wp_db_host     = azurerm_mysql_flexible_server.wpdbserver.fqdn
    http_host      = local.site_url
    http_conf      = "${local.site_url}.conf" 
    http_port      = 80
  })
}




