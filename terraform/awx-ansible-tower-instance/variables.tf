variable "ssh_public_key" {
  type        = string
  description = "Content of your SSH public key, matching the private key below"
}

variable "ssh_private_key" {
  type        = string
  description = "Content of your SSH private key, matching the public key above"
  sensitive   = true
}
