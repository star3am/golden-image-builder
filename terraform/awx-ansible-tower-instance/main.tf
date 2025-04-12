terraform {
  required_version = "~> 1.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 3.57"
    # }
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "~> 4.66"
    }
  }
}

provider "aws" {}

# provider "azurerm" {
#   features {}
# }

provider "google" {}

module "awx_ansible_tower" {
  source                     = "github.com/star3am/terraform-hashicorp-hashiqube.git?ref=master"
  # source                     = "star3am/hashiqube/hashicorp"
  deploy_to_aws              = true
  aws_instance_type          = "t2.large"
  use_packer_image           = var.use_packer_image
  deploy_to_azure            = false
  deploy_to_gcp              = false
  debug_user_data            = true
  ssh_public_key             = var.ssh_public_key
  ssh_private_key            = var.ssh_private_key
  debug_allow_ssh_cidr_range = "0.0.0.0/0"
  whitelist_cidrs            = ["101.189.198.17/32"]
  vagrant_provisioners       = "basetools,docker,minikube,ansible-tower"
}

data "external" "tower_token" {
  program = ["/bin/bash", "-c", "${var.tower_cli_local} login --conf.host ${var.tower_host} --conf.insecure --conf.username admin --conf.password \"${var.tower_password}\""]
}

locals {
  timestamp = timestamp()
}

resource "null_resource" "awx_cli" {
  triggers = {
    timestamp = local.timestamp
  }

  provisioner "remote-exec" {
    inline = [
      "${var.tower_cli_remote} --conf.host module.awx_ansible_tower[0].awx_ansible_tower_ip_address, -f human job_templates launch ansible-role-example-role --monitor --filter status --conf.insecure --conf.token ${data.external.tower_token.result.token}",
    ]
    on_failure = continue
    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
      host        = module.awx_ansible_tower[0].awx_ansible_tower_ip_address
    }
  }
  
  provisioner "local-exec" {
    command    = "${var.tower_cli_local} --conf.host module.awx_ansible_tower[0].awx_ansible_tower_ip_address -f human job_templates launch ansible-role-example-role --monitor --filter status --conf.insecure --conf.token ${data.external.tower_token.result.token}"
    on_failure = continue
  }
}
