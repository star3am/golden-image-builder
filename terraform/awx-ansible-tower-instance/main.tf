terraform {
  required_version = "~> 1.0"
}

provider "aws" {}

provider "azurerm" {
  features {}
}

provider "google" {}

module "hashiqube" {
  source                     = "github.com/star3am/terraform-hashicorp-hashiqube?ref=master"
  deploy_to_aws              = true
  deploy_to_azure            = false
  deploy_to_gcp              = false
  debug_user_data            = true
  debug_allow_ssh_cidr_range = "0.0.0.0/0"
  whitelist_cidr             = "101.189.198.17"
  vagrant_provisioners       = "basetools,docker,minikube,ansible-tower"
}
