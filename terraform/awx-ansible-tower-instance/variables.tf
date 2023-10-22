variable "deploy_to_aws" {
  type        = bool
  default     = false
  description = "Deploy VM on AWS"
}

variable "deploy_to_gcp" {
  type        = bool
  default     = false
  description = "Deploy VM on GCP"
}

variable "deploy_to_azure" {
  type        = bool
  default     = false
  description = "Deploy VM on Azure"
}

variable "whitelist_cidr" {
  type        = map(string)
  description = "Additional CIDRs to whitelist"
  default = {
    "1102" = "58.161.109.181/32"
    "1103" = "1.132.108.175/32"
    "1104" = "1.128.107.206/32"
  }
}

variable "ssh_public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUOc8QvTGjoLc/8cU4p3iFl0xGfELUkwOYt7/Ze2AEOjeb2fI5UzypQ0k0E9QDBN9KPIt2MLb14KEezpekeOxeWQEccFGJz5dFYoCP+q8UvtXBn8KRsIVd6w3JpVvMbn4oQLNyJH7A2aruP9ysIFsKVnWGHAI5JZY2SmhqWbOHVozZNsDC7Qhyz8l5OD7W8surhm1LVplQ7AP8DfVBfJlfx5rD9571qyl2ExfD9Tix++/u6gEeFNR35SFppvB8JHhVrnSQ4WGa1kutAJRr7bDfyeC8n727p96G+HO3CKcc6A+3KmfsV4NW8hZ4u4RUJjRi/DC2+qMDdKlyQBG81KjJ"
  description = "SSH public key"
}

variable "azure_region" {
  type        = string
  description = "The region in which all Azure resources will be launched"
  default     = "Australia East"
}

variable "azure_instance_type" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "Azure instance type"
}

variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "The region in which all AWS resources will be launched"
}

variable "aws_instance_type" {
  type        = string
  default     = "t2.medium"
  description = "AWS instance type"
}

variable "aws_ami_id" {
  type        = string
  default     = "ami-07948ca28a01e83f9" # ap-south-1
  description = "AWS AMI ID"
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

variable "gcp_project" {
  type        = string
  default     = "default"
  description = "GCP project ID"
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
  type        = string
  default     = "n1-standard-1"
  description = "VM instance type"
}

variable "gcp_custom_metadata" {
  description = "A map of metadata key value pairs to assign to the Compute Instance metadata"
  type        = map(string)
  default     = {}
}

variable "gcp_root_volume_disk_size_gb" {
  type        = number
  description = "The size, in GB, of the root disk volume on each HashiQube node"
  default     = 16
}

variable "gcp_root_volume_disk_type" {
  type        = string
  description = "The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "tower_cli_remote" {
  type        = string
  default     = "~/.local/bin/awx"
  description = "Path of the AWX CLI utility on the VM"
}

variable "tower_cli_local" {
  type        = string
  default     = "~/.local/bin/awx"
  description = "Path of the AWX CLI utility on the build agent"
}

variable "tower_host" {
  type        = string
  default     = "https://13.232.55.64:8043"
  description = "Tower AWX Host endpoint"
}

variable "tower_username" {
  type        = string
  default     = "admin"
  description = "AWX Tower username"
}

variable "tower_password" {
  type        = string
  default     = "aix1rii3Bahshuleikei5y" #tfsec:ignore:general-secrets-sensitive-in-variable
  description = "AWX Tower password"
}

variable "vm_username" {
  type        = string
  default     = "ubuntu"
  description = "VM username"
}

variable "vm_password" {
  type        = string
  default     = "aix1rii3Bahshuleikei5y" #tfsec:ignore:general-secrets-sensitive-in-variable
  description = "VM password"
}
