#Create Webtire subnet

resource "azurerm_subnet" "websubnet" {
    name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.web_subnet_address  
   
}

#create network security group(NSG)

resource "azurerm_network_security_group" "web_subnet_nsg" {
    name = "${azurerm_subnet.websubnet.name}-nsg"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location  
}

#associating NSG and subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
    subnet_id = azurerm_subnet.websubnet.id
    network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
    depends_on = [ azurerm_network_security_rule.web_subnet_nsg_rule_inbound ]
}

#create NSG rule for web_subnet
locals {
    web_subnet_inbound_port_map = {
        "100": "80",  #If the key start with a number, we must use ":" syntext instead of "="
        "110": "443",
        "120": "22"
        }
}

resource "azurerm_network_security_rule" "web_subnet_nsg_rule_inbound" {
    for_each = local.web_subnet_inbound_port_map
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
    network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
  
}
# This below one also works, using dynamic block
# locals {
#   web_subnet_inbound_port_map = [
#     { priority = "100", port = "80" },
#     { priority = "110", port = "443" },
#     { priority = "120", port = "22" }
#   ]
# }

# resource "azurerm_network_security_rule" "web_subnet_nsg_rule_inbound" {
#   name                        = "web-subnet-nsg"
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name

#   dynamic "security_rule" {
#     for_each = local.web_subnet_inbound_port_map
#     content {
#       name                        = "rule-port-${security_rule.value.port}"
#       priority                    = security_rule.value.priority
#       direction                   = "Inbound"
#       access                      = "Allow"
#       protocol                    = "Tcp"
#       source_port_range           = "*"
#       destination_port_range      = security_rule.value.port
#       source_address_prefix       = "*"
#       destination_address_prefix  = "*"
#     }
#   }
#}