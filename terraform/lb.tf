# Load Balancer
resource "azurerm_lb" "load_balancer" {
  name                = "${local.name_prefix}-lb"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${local.name_prefix}-lb-public-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${local.name_prefix}-lb-public-ip"
  location            = local.region
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_dns_zone" "wordpress_dns_zone" {
  name                = local.site_url
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_dns_a_record" "site_lb_record" {
  name                = local.site_url
  zone_name           = azurerm_dns_zone.wordpress_dns_zone.name
  resource_group_name = azurerm_resource_group.resource_group.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.lb_public_ip.id
}

resource "azurerm_lb_backend_address_pool" "wordpress_address_pool" {

  name            = "${local.name_prefix}-backend-address-pool"
  loadbalancer_id = azurerm_lb.load_balancer.id
}

resource "azurerm_lb_backend_address_pool_address" "wordpress_address_pool_address" {
  for_each = tomap({ for vm in azurerm_linux_virtual_machine.wordpress_virtual_machine : vm.name => vm })

  name                    = "${each.value.name}-backend-address-pool-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.wordpress_address_pool.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = each.value.private_ip_address
}

resource "azurerm_lb_rule" "wordpress_lb_rule" {
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = "Wordpress_lb_rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_public_ip.lb_public_ip.name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.wordpress_address_pool.id]
}