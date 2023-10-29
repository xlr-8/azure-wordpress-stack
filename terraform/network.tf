resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = local.region
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "${local.name_prefix}-vm-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}
resource "azurerm_subnet" "db_subnet" {
  name                 = "${local.name_prefix}-db-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
  delegation {
    name = "mysql_flexible_delegation"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}


# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  count               = 2
  name                = "${local.name_prefix}-pip-${count.index}"
  location            = local.region
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"

  tags = {
    environment = local.environment
  }
}

resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "${local.name_prefix}-nic-${count.index}"
  location            = local.region
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${local.name_prefix}-nic-configuration"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${local.name_prefix}-nsg"
  location            = local.region
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = local.environment
  }
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow_http"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}