terraform {
  backend "azurerm" {
    resource_group_name  = "DefaultResourceGroup-EUS"
    storage_account_name = "demostorage3000"
    container_name       = "tf-blob"
    key                  = "terraform.tfstate"
  }
}