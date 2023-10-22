terraform {
  required_version = "~> 0.13"
}

provider "google" {
  version = "~> 3.40.0"
  region  = var.gcp_region
  project = var.gcp_project_id
}

resource "null_resource" "check" {
  triggers = {
    deploy_to_gcp = var.deploy_to_gcp
    my_ipaddress  = data.external.myipaddress.result.ip
  }
}

module "gcp-vm" {
  source                       = "../"
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
  gcp_cluster_tag_name         = var.gcp_cluster_tag_name
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
  source_image_family          = var.source_image_family
  source_image                 = var.source_image
}
