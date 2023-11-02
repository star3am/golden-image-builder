terraform {
  required_version = "~> 1.0"
}

module "hashiqube" {
  source               = "star3am/hashiqube/hashicorp"
  version              = "1.0.18"
  deploy_to_aws        = true
  deploy_to_azure      = false
  deploy_to_gcp        = false
  vagrant_provisioners = "basetools,docker,minikube,ansible-tower"
}
