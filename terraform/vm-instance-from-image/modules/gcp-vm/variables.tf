variable "deploy_to_gcp" {}

variable "whitelist_cidr" {}

variable "ssh_public_key" {}

variable "my_ipaddress" {}

variable "gcp_cluster_name" {}

variable "gcp_cluster_description" {}

variable "gcp_cluster_tags" {}

variable "gcp_cluster_size" {}

variable "gcp_region" {}

variable "gcp_account_id" {}

variable "gcp_project_id" {}

variable "gcp_zones" {}

variable "gcp_machine_type" {}

variable "gcp_custom_metadata" {}

variable "gcp_root_volume_disk_size_gb" {}

variable "gcp_root_volume_disk_type" {}

variable "is_windows" {}

variable "tower_cli_remote" {}

variable "tower_cli_local" {}

variable "tower_host" {}

variable "tower_username" {}

variable "tower_password" {}

variable "vm_username" {}

variable "vm_password" {}

variable "source_image" {
  type        = string
  description = "(Optional) Source image of the VM."
  default     = "latest"
}

variable "source_image_family" {
  type        = string
  description = "(Optional) Image family of source image, it's required if source_image is latest."
  default     = ""
}
