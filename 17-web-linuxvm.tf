resource "azurerm_linux_virtual_machine" "web_linux" {
    name = "${local.resources_name_prefix}-wen-linux"
    computer_name = "web-linux-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = "Standard_DS1_v2"
    admin_username = "ahamedadmin"
    network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic.id ]
    admin_ssh_key {
      username = "ahamedadmin"
      public_key = file("E:\\Books\\Terraform\\Terraform-Azure\\Azure-TF\\azure-virtual-network\\ssh-keys\\terraform-azure.pub")
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "RedHat"
      offer = "RHEL"
      sku = "8-LVM"
      version = "Latest"
    }
    custom_data = base64encode(local.web_custom_data)
}