terraform {
  required_version = "~> 0.13"
}

provider "azurerm" {
  version = "~> 2.29.0"
  features {}
}

resource "null_resource" "check" {
  triggers = {
    deploy_to_azure      = var.deploy_to_azure
    my_ipaddress         = data.external.myipaddress.result.ip
    image_version_number = var.image_version_number
  }
}

module "azure-vm" {
  source                    = "../"
  deploy_to_azure           = var.deploy_to_azure #TODO: clean up this if no need to use this var
  whitelist_cidr            = var.whitelist_cidr
  ssh_public_key            = var.ssh_public_key
  my_ipaddress              = data.external.myipaddress.result.ip
  azure_region              = var.azure_region
  azure_instance_type       = var.azure_instance_type
  is_windows                = var.is_windows
  image_version_number      = var.image_version_number
  windows_admin_username    = "windows"
  windows_admin_password    = "Abcd_12345!"
  image_definition          = var.image_definition
  shared_image_gallery_name = var.shared_image_gallery_name
  subscription_id           = data.azurerm_subscription.current.subscription_id
  tower_cli_remote          = var.tower_cli_remote
  tower_cli_local           = var.tower_cli_local
  tower_host                = var.tower_host
  tower_username            = var.tower_username
  tower_password            = var.tower_password
  vm_username               = var.vm_username
  vm_password               = var.vm_password
}
