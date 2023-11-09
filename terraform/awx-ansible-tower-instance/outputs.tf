output "awx_ansible_tower_ip_address" {
  value       = try(module.aws_hashiqube[0].hashiqube_ip, null)
  description = "AWX Tower IP address"
}
