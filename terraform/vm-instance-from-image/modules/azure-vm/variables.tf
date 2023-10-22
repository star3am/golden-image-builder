variable "deploy_to_azure" {}

variable "whitelist_cidr" {
  type        = map(any)
  description = "A map of security rule priority and whitelist ip address for vm security rules. Map key is security rule priority, map value is CIDR IP address. Example: {1000: '10.0.0.0/32', 1001: '10.0.0.1/32'}."
}

variable "my_ipaddress" {}

variable "ssh_public_key" {
  type        = string
  description = "A stirng of the public key."
}

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

variable "windows_admin_username" {
  type        = string
  description = "Windows administrator username"
}

variable "windows_admin_password" {}

variable "image_definition" {}

variable "shared_image_gallery_name" {}

variable "subscription_id" {}

variable "tower_cli_remote" {}

variable "tower_cli_local" {}

variable "tower_host" {}

variable "tower_username" {}

variable "tower_password" {}

variable "vm_username" {}

variable "vm_password" {}
