output "web_linux_public_ip"{
    description = "Web linux VM public address"
    value = azurerm_public_ip.web_linuxvm_publicip.ip_address
}

output "web_linux_network_interface_id"{
    description = "web Linux VM Network Interface ID"
    value = azurerm_network_interface.web_linuxvm_nic.id
}

output "web_linux_nic_private_ip_address" {
    description = "web linux vm private IP address"
    value = [azurerm_network_interface.web_linuxvm_nic.private_ip_addresses]
  
}

output "Web_linux_public_ip_address" {
    description = "Web linux virtual machine public ip"
    value = azurerm_linux_virtual_machine.web_linux.public_ip_address
}

output "Web_linux_private_ip_address"{
    description = "Web Linux Virtaul Machine Private IP"
    value = azurerm_linux_virtual_machine.web_linux.private_ip_address
}

output "web_linux_virtual_machine_id_128bit" {
    description = "Web linux virtual machine id - 128-bit identifier"
    value = azurerm_linux_virtual_machine.web_linux.virtual_machine_id
}

output "web_linux_virtual_machine_id" {
    description = "Web linux virtual Machine ID"
    value = azurerm_linux_virtual_machine.web_linux.id
}