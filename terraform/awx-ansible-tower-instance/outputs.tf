output "your_ipaddress" {
  value       = data.external.myipaddress.result.ip
  description = "IP address of the machine that ran Terraform"
}

# AWS
output "aws_vm_ip" {
  value       = var.deploy_to_aws ? try(module.aws_vm[0].vm_ip, null) : null
  description = "VM IP address"
}

output "aws_windows_password" {
  value       = var.deploy_to_aws ? try(module.aws_vm[0].aws_windows_password, null) : null
  description = "VM password"
}

output "aws_vm_ssh" {
  value       = var.deploy_to_aws ? try("ssh ubuntu@${module.aws_vm[0].vm_ip}", null) : null
  description = "Command to SSH to the VM"
}

# Azure
output "azure_vm_ip" {
  value       = var.deploy_to_azure ? try(module.azure_vm[0].vm_ip, null) : null
  description = "VM IP address"
}

output "azure_vm_ssh" {
  value       = var.deploy_to_azure ? try("ssh ubuntu@${module.azure_vm[0].vm_ip}", null) : null
  description = "Command to SSH to the VM"
}

# GCP
output "gcp_vm_ip" {
  value       = var.deploy_to_gcp ? try(module.gcp_vm[0].vm_ip, null) : null
  description = "VM IP address"
}

output "gcp_vm_ssh" {
  value       = var.deploy_to_gcp ? try("ssh ubuntu@${module.gcp_vm[0].vm_ip}", null) : null
  description = "Command to SSH to the VM"
}
