#virtual_network_name
output "virtual_network_name"{
    description = "virtual network name"
    value = azurerm_virtual_network.vnet.name
}

#virtual_network_id
output "virtual_network_id"{
    description = "vnet_id"
    value = azurerm_virtual_network.vnet.id
}

#websubnet_name
output "web_subnet_name"{
    description = "web_subnet_name"
    value = azurerm_subnet.websubnet.name
}

#websubnet_id
output "web_subnet_id"{
    description = "web_subnet_id"
    value = azurerm_subnet.websubnet.id
}

#websubnet_nsg_name
output "websubnet_nsg_name"{
    description = "websubnet_nsg_name"
    value = azurerm_network_security_group.web_subnet_nsg.name
}

#websubnet_nsg_name
output "websubnet_nsg_id"{
    description = "websubnet_nsg_name"
    value = azurerm_network_security_group.web_subnet_nsg.id
}

output "resource_group_name" {
    description = "Resource Name"
    value = azurerm_resource_group.rg.name
  
}