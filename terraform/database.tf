resource "azurerm_private_dns_zone" "privdnszone" {
  name                = local.private_dns_zone_name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnsvnetvmlink" {
  name                  = local.private_dns_zone_virtual_network_link_name
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.privdnszone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# WordPress MySQL flexible database server configuration
resource "azurerm_mysql_flexible_server" "wpdbserver" {
  name                = local.mysql_server_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = local.region
  zone                = "1"

  sku_name               = local.mysql_sku_name
  version                = local.mysql_server_version
  administrator_login    = local.mysql_admin_login
  administrator_password = local.mysql_admin_password
  backup_retention_days  = local.mysql_server_backup_retention_length
  delegated_subnet_id    = azurerm_subnet.db_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.privdnszone.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.dnsvnetvmlink]
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = local.mysql_database_name
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = local.mysql_server_name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"

  depends_on = [azurerm_mysql_flexible_server.wpdbserver]
}