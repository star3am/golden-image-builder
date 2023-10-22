variable "deploy_to_gcp" {
  type        = bool
  default     = true
  description = "Deploy VM on GCP"
}

variable "is_windows" {
  type        = bool
  default     = false
  description = "Is this a Windows VM?"
}

variable "whitelist_cidr" {
  type        = map(string)
  description = "Additional CIDRs to whitelist"
  default = {
    "1002" = "1.132.108.170/32"
    "1003" = "1.132.108.175/32"
    "1004" = "1.128.107.206/32"
  }
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key"
}

variable "source_ami_prefix" {
  type    = string
  default = "ubuntu-2004"
}

variable "gcp_region" {
  type        = string
  description = "The region in which all GCP resources will be launched"
  default     = "australia-southeast1"
}

variable "gcp_account_id" {
  type        = string
  description = "Account ID"
  default     = "sa-consul-compute-prod"
}

variable "gcp_project_id" {
  type        = string
  description = "Account Project ID"
  default     = "riaannolan-142321"
}

variable "gcp_cluster_name" {
  type        = string
  default     = "hashiqube"
  description = "Cluster name"
}

variable "gcp_cluster_description" {
  type        = string
  default     = "hashiqube"
  description = "the description for the cluster"
}

variable "gcp_cluster_tag_name" {
  type        = string
  default     = "hashiqube"
  description = "Cluster tag to apply"
}

variable "gcp_cluster_size" {
  type        = number
  default     = 1
  description = "size of the cluster"
}

variable "gcp_zones" {
  type        = list(string)
  description = "The zones accross which GCP resources will be launched"

  default = [
    "australia-southeast1-a",
    "australia-southeast1-b",
    "australia-southeast1-c",
  ]
}

variable "gcp_machine_type" {
  type    = string
  default = "n1-standard-1"
}

variable "gcp_custom_metadata" {
  description = "A map of metadata key value pairs to assign to the Compute Instance metadata"
  type        = map(string)
  default     = {}
}

variable "gcp_root_volume_disk_size_gb" {
  type        = number
  description = "The size, in GB, of the root disk volume on each HashiQube node"
  default     = 512
}

variable "gcp_root_volume_disk_type" {
  type        = string
  description = "The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "tower_cli_remote" {
  type    = string
  default = "/usr/local/bin/awx"
}

variable "tower_cli_local" {
  type    = string
  default = "/usr/local/bin/awx"
}

variable "tower_host" {
  type    = string
  default = "https://13.232.55.64:8043"
}

variable "tower_username" {
  type    = string
  default = "admin"
}

variable "tower_password" {
  type    = string
  default = "aix1rii3Bahshuleikei5y"
}

variable "vm_username" {
  type    = string
  default = "ansible"
}

variable "vm_password" {
  type    = string
  default = "aix1rii3Bahshuleikei5y"
}

variable "google_compute_address" {
  type    = string
  default = ""
}

variable "source_image_family" {
  type        = string
  description = "(Optional) Source image of the VM. It's requried if source_image is not set."
  default     = "soe-ubuntu-1804-lts"
}

variable "source_image" {
  type        = string
  description = "(Optional) Source image of the VM. It's requried if source_image_family is not set."
  default     = ""
}
