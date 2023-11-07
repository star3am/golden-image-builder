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
  }
}

provider "aws" {}

provider "azurerm" {
  features {}
}

provider "google" {}

module "aws_hashiqube" {
  # source                     = "star3am/hashiqube/hashicorp//modules/aws-hashiqube"
  source                     = "git::https://github.com/star3am/terraform-hashicorp-hashiqube.git//modules/aws-hashiqube?ref=debug"
  deploy_to_aws              = true
  aws_instance_type          = "t2.large"
  deploy_to_azure            = false
  deploy_to_gcp              = false
  debug_user_data            = true
  debug_allow_ssh_cidr_range = "0.0.0.0/0"
  whitelist_cidr             = "101.189.198.17/32"
  vagrant_provisioners       = "basetools,docker,minikube,ansible-tower"
}

# module "gcp_hashiqube" {
#   # source        = "star3am/hashiqube/hashicorp//modules/aws-hashiqube"
#   source        = "git::https://github.com/star3am/terraform-hashicorp-hashiqube.git//modules/gcp-hashiqube?ref=debug"
#   deploy_to_gcp = false
# }

# module "azure_hashiqube" {
#   # source          = "star3am/hashiqube/hashicorp//modules/aws-hashiqube"
#   source          = "git::https://github.com/star3am/terraform-hashicorp-hashiqube.git//modules/azure-hashiqube?ref=debug"
#   deploy_to_azure = false
# }
