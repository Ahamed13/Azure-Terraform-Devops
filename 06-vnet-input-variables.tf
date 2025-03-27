##virtual network
variable "vnet_name" {
    description = "Virtual Network name"
    type = string
    default = "vnet-default"
}

variable "vnet_address_space" {
    description = "virtual network address_space"
    type = list(string)
    default = [ "10.0.0.0/16" ]  
}

#web subnet name
variable "web_subnet_name" {
    description = "Web subnet name"
    type = string
    default = "websubnet"  
}

#web subnet address_space
variable "web_subnet_address" {
    description = "web subnet address_space"
    type = list(string)
    default = [ "10.0.1.0/24" ]
  
}

#App subnet name
variable "app_subnet_name" {
    description = "App subnet name"
    type = string
    default = "appsubnet"  
}

#App subnet address_space
variable "app_subnet_address" {
    description = "App subnet address_space"
    type = list(string)
    default = [ "10.0.11.0/24" ]
  
}


#DB subnet name
variable "db_subnet_name" {
    description = "db subnet name"
    type = string
    default = "dbsubnet"  
}

#DB subnet address_space
variable "db_subnet_address" {
    description = "db subnet address_space"
    type = list(string)
    default = [ "10.0.21.0/24" ]
  
}

#Bastion/Mgm subnet Name
variable "bastion_subnet_name" {
    description = "bastion subnet name"
    type = string
    default = "bastionsubnet"  
}

#DB subnet address_space
variable "bastion_subnet_address" {
    description = "bastion subnet address_space"
    type = list(string)
    default = [ "10.0.100.0/24" ]
  
}
