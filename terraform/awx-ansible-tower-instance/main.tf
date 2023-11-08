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
  source                     = "star3am/hashiqube/hashicorp"
  # source                     = "git::https://github.com/star3am/terraform-hashicorp-hashiqube.git//modules/aws-hashiqube?ref=debug"
  deploy_to_aws              = true
  aws_instance_type          = "t2.large"
  deploy_to_azure            = false
  deploy_to_gcp              = false
  debug_user_data            = true
  # ssh_public_key             = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgkrDFTASaZYyJfGd0swmUZaol3JSZmO6D74230CtZjz/iNGKa+dY/6kvA0ABUhGZQu9a3LGD7tDMYmkKoAjpb177vwfgjTDMHwVKn2kGs/yqb7UMBMYtKP3FmmCUyGG5VUIaQIODuUSkgJ+sd0AptiMIQW+GrQ/KhcN5255mUb6rklWl83pYII1j+qgvDO/YrHq4QL34r5z4oPz9gO8f0l6kN8Hz6BEhAIzArg8kDI9lrsPXypCqlahE49cuzNH3C5GEC9MHo46U6+ZG2IOwCXjiP5ohnXyG8ho8N1BVpDa0xyVevy4COg4malaLVcRwP73YwgxiitNLWcq8k8nB riaan@Riaans-MacBook-Pro.local" 
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
