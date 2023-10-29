locals {
  #Global
  environment = var.environment
  name_prefix = "${var.project_name}-${var.environment}"
  region      = var.region

  ansible_vars_output_path      = var.ansible_vars_output_path
  ansible_inventory_output_path = var.ansible_inventory_output_path
  ssh_private_key_output_path   = var.ssh_private_key_output_path



  site_url = var.site_url

  #VMs
  vm_sizing         = var.vm_sizing
  vm_admin_login    = var.vm_admin_login
  vm_admin_password = var.vm_admin_password

  #BDD
  mysql_admin_login                    = var.mysql_admin_login
  mysql_admin_password                 = var.mysql_admin_password
  mysql_server_name                    = "${local.name_prefix}-mysql"
  mysql_database_name                  = "${local.name_prefix}-wpdb"
  mysql_sku_name                       = var.mysql_sku_name
  mysql_server_version                 = var.mysql_server_version
  mysql_server_backup_retention_length = var.mysql_server_backup_retention_length

  private_dns_zone_name                      = "${local.name_prefix}-mysql.database.azure.com"
  private_dns_zone_virtual_network_link_name = "${local.name_prefix}-link"

}
