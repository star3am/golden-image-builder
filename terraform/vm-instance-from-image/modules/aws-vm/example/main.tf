terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  version = "~> 3.8.0"
  region  = var.aws_region
}

resource "null_resource" "check" {
  triggers = {
    my_ipaddress  = data.external.myipaddress.result.ip
    latest_ami_id = data.aws_ami.latest.image_id
  }
}

module "aws-vm" {
  source            = "../"
  deploy_to_aws     = var.deploy_to_aws
  ssh_public_key    = var.ssh_public_key
  aws_instance_type = var.aws_instance_type
  aws_region        = var.aws_region
  whitelist_cidr    = var.whitelist_cidr
  my_ipaddress      = data.external.myipaddress.result.ip
  aws_ami_id        = data.aws_ami.latest.image_id
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
