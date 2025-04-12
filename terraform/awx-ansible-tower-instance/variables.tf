variable "ssh_public_key" {
  type        = string
  description = "Content of your SSH public key, matching the private key below"
}

variable "ssh_private_key" {
  type        = string
  description = "Content of your SSH private key, matching the public key above"
  sensitive   = true
}

variable "use_packer_image" {
  type        = bool
  description = "Use your Packer build image"
}

variable "tower_cli_remote" {
  type        = string
  default     = "~/.local/bin/awx"
  description = "Location of awx tower cli utility"
}

variable "tower_cli_local" {
  type        = string
  default     = "/home/vagrant/.local/bin/awx"
  description = "Location of awx tower cli utility"
}

variable "tower_host" {
  type        = string
  default     = "http://localhost:8043/"
  description = "The Tower host endpoint"
}

variable "tower_password" {
  type        = string
  sensitive   = true
  default     = "password"
  description = "Tower password"
}
