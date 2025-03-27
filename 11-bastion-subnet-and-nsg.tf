#Create bastiontire subnet
resource "azurerm_subnet" "bastionsubnet" {
    name = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.bastion_subnet_address  
    depends_on = [ azurerm_virtual_network.vnet ]
}

#create network security group(NSG)
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
    name = "${azurerm_subnet.bastionsubnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location  
}

#create NSG rule for bastion_subnet
locals {
    bastion_subnet_inbound_port_map = {
        "100": "22",  #If the key start with a number, we must use ":" syntext instead of "="
        "110": "3389"
        }
}

resource "azurerm_network_security_rule" "bastion_subnet_nsg_rule_inbound" {
    for_each = local.bastion_subnet_inbound_port_map
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
    network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
  
}

#associating NSG and subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
    subnet_id = azurerm_subnet.bastionsubnet.id
    network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
    depends_on = [ azurerm_network_security_rule.bastion_subnet_nsg_rule_inbound ]
}


