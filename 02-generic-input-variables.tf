#Business Division
variable "business_division" {
    description = "Business Division in the large organization this Infrastructure belongs"
    type = string
    default = "sap"
}

# Environment Variable
variable "environment" {
    description = "environment variables used as a prefix"
    type = string
    default = "dev"  
}

#Azure resource group
variable "resource_group_name" {
    description = "Resource Group Name"
    type = string
    default = "rg-default"
}

#Azure resources Location
variable "resource_group_location" {
    description = "Region in which azure resources to be created"
    type = string
    default = "eastus"
}
