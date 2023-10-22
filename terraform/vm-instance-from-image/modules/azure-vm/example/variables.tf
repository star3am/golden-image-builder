variable "deploy_to_azure" {}

variable "whitelist_cidr" {
  type        = map(any)
  description = "A map of security rule priority and whitelist ip address for vm security rules. Map key is security rule priority, map value is CIDR IP address. Example: {1000: '10.0.0.0/32', 1001: '10.0.0.1/32'}."
}

variable "ssh_public_key" {}

variable "azure_region" {}

variable "azure_instance_type" {}

variable "is_windows" {}

variable "image_version_number" {
  type        = string
  description = "Image version number in shared image gallery"
  default     = "latest"
  validation {
    condition     = can(regex("^latest$|^[0-9]+\\.[0-9]+\\.[0-9]+$", var.image_version_number))
    error_message = "The image version number doesn't fit the regular expression of image version number."
  }
}

variable "image_definition" {
  type        = string
  description = "Image definition in shared image gallery" #example value: windows-2019
}

variable "shared_image_gallery_name" {
  type        = string
  description = "Name of Azure shared image gallery"
}

variable "tower_cli_remote" {}

variable "tower_cli_local" {}

variable "tower_host" {}

variable "tower_username" {}

variable "tower_password" {}

variable "vm_username" {}

variable "vm_password" {}
