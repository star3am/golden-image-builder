output "awx_ansible_tower_ip_address" {
  value       = try(module.awx_ansible_tower[0].hashiqube_ip, null)
  description = "AWX Tower IP address"
}
