terraform {
  required_version = "~> 1.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.57"
    }
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "~> 4.66"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # Default authentication is via ENV variables see: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
  # shared_credentials_files = [file(var.aws_credentials)]
  # profile                  = var.aws_profile
}

provider "azurerm" {
  # Default authentication is via ENV variables see: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal
  features {}
}

provider "google" {
  # Default authentication is via ENV variables see: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference.html#authentication-configuration
  # credentials = file(var.gcp_credentials)
  project = var.gcp_project
  region  = var.gcp_region
}

data "external" "myipaddress" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

data "azurerm_subscription" "current" {}

locals {
  azure_version_number = var.image_version_number
}

resource "null_resource" "check" {
  triggers = {
    deploy_to_azure      = var.deploy_to_azure
    deploy_to_gcp        = var.deploy_to_gcp
    deploy_to_aws        = var.deploy_to_aws
    deploy_to_vmware     = var.deploy_to_vmware
    my_ipaddress         = data.external.myipaddress.result.ip
    image_version_number = var.image_version_number
  }
}

module "gcp_vm" {
  count = var.deploy_to_gcp ? 1 : 0

  source                       = "./modules/gcp-vm"
  deploy_to_gcp                = var.deploy_to_gcp
  whitelist_cidr               = var.whitelist_cidr
  gcp_cluster_description      = var.gcp_cluster_description
  gcp_cluster_name             = var.gcp_cluster_name
  gcp_cluster_size             = var.gcp_cluster_size
  gcp_machine_type             = var.gcp_machine_type
  gcp_region                   = var.gcp_region
  gcp_account_id               = var.gcp_account_id
  gcp_project_id               = var.gcp_project_id
  gcp_root_volume_disk_size_gb = var.gcp_root_volume_disk_size_gb
  gcp_root_volume_disk_type    = var.gcp_root_volume_disk_type
  gcp_zones                    = var.gcp_zones
  gcp_cluster_tags             = var.gcp_cluster_tags
  gcp_custom_metadata          = var.gcp_custom_metadata
  ssh_public_key               = var.ssh_public_key
  my_ipaddress                 = data.external.myipaddress.result.ip
  is_windows                   = var.is_windows
  tower_cli_remote             = var.tower_cli_remote
  tower_cli_local              = var.tower_cli_local
  tower_host                   = var.tower_host
  tower_username               = var.tower_username
  tower_password               = var.tower_password
  vm_username                  = var.vm_username
  vm_password                  = var.vm_password
  source_image                 = var.source_image
  source_image_family          = var.source_image_family
}

module "aws_vm" {
  count = var.deploy_to_aws ? 1 : 0

  source            = "./modules/aws-vm"
  deploy_to_aws     = var.deploy_to_aws
  ssh_public_key    = var.ssh_public_key
  aws_instance_type = var.aws_instance_type
  aws_region        = var.aws_region
  whitelist_cidr    = var.whitelist_cidr
  my_ipaddress      = data.external.myipaddress.result.ip
  aws_ami_id        = var.aws_ami_id
  is_windows        = var.is_windows
  tower_cli_remote  = var.tower_cli_remote
  tower_cli_local   = var.tower_cli_local
  tower_host        = var.tower_host
  tower_username    = var.tower_username
  tower_password    = var.tower_password
  vm_username       = var.vm_username
  vm_password       = var.vm_password
  source_ami_prefix = var.source_ami_prefix
}

module "azure_vm" {
  count = var.deploy_to_azure ? 1 : 0

  source                    = "./modules/azure-vm"
  deploy_to_azure           = var.deploy_to_azure
  whitelist_cidr            = var.whitelist_cidr
  ssh_public_key            = var.ssh_public_key
  my_ipaddress              = data.external.myipaddress.result.ip
  azure_region              = var.azure_region
  azure_instance_type       = var.azure_instance_type
  is_windows                = var.is_windows
  image_version_number      = local.azure_version_number
  windows_admin_username    = var.windows_admin_username
  windows_admin_password    = var.windows_admin_password
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
