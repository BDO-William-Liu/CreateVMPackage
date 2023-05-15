module "create-azure-vm-package" {
    source = "./ModuleVM"

    name = var.name
    location = var.location
    size = var.size
    admin_username = var.admin_username
    admin_password = var.admin_password
    address_space = var.address_space
    address_prefix = var.address_prefix
}