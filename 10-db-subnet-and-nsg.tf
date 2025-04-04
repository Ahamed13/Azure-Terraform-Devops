#Create dbtire subnet
resource "azurerm_subnet" "dbsubnet" {
    name = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.db_subnet_address  
    depends_on = [azurerm_virtual_network.vnet]
}

#create network security group(NSG)
resource "azurerm_network_security_group" "db_subnet_nsg" {
    name = "${azurerm_subnet.dbsubnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location  
}

#create NSG rule for db_subnet
locals {
    db_subnet_inbound_port_map = {
        "100": "3306",  #If the key start with a number, we must use ":" syntext instead of "="
        "110": "1433",
        "120": "5432"
        }
}

resource "azurerm_network_security_rule" "db_subnet_nsg_rule_inbound" {
    for_each = local.db_subnet_inbound_port_map
    name                        = "rule-port-${each.value}"
    priority                    = each.key
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = each.value
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.db_subnet_nsg.name
  
}

#associating NSG and subnet
resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_associate" {
    subnet_id = azurerm_subnet.dbsubnet.id
    network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
    depends_on = [ azurerm_network_security_rule.db_subnet_nsg_rule_inbound ]
}
