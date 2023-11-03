terraform {
  required_version = "~> 1.0"
}

provider "aws" {}

provider "azurerm" {
  features {}
}

provider "google" {}

module "hashiqube" {
  source               = "github.com/star3am/terraform-hashicorp-hashiqube?ref=master"
#   version              = "1.0.18"
  deploy_to_aws        = true
  deploy_to_azure      = false
  deploy_to_gcp        = false
#   ssh_public_key       = var.ssh_public_key
#   ssh_private_key      = var.ssh_private_key
  vagrant_provisioners = "basetools,docker,minikube,ansible-tower"
}
