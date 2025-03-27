resource "azurerm_network_interface" "web_linuxvm_nic" {
    name = "${local.resources_name_prefix}-web-linux-nic"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
      name = "web-linux-ip-1"
      subnet_id = azurerm_subnet.websubnet.id
      public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip.id
      private_ip_address_allocation = "Dynamic"
    }
  
}