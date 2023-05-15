variable "name" {
    description = "the name of the virtual machine that is to be created"
    type = string
    default = "myterraformVM"
}

variable "location" {
    description = "the desired server location for the resource group"
    type = string
    default = "East US"
}

variable "size" {
    description = "the desired size for the virtual machine"
    type = string
    default = "Standard_DS1_v2"
}

variable "admin_username" {
    description = "username to connect to the virtual machine"
    type = string
    default = "azureuser"
    sensitive = true
}

variable "admin_password" {
    description = "password to connect to the virtual machine"
    type = string
    default = "P@$$w0rd1234!"
    sensitive = true
}

variable "address_space" {
    description = "address space of the azure virtual network"
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "address_prefix" {
    description = "address prefix of the azure subnet"
    type = list(string)
    default = ["10.0.2.0/24"]
}