output "vm_ip" {
  value = aws_instance.vm.public_ip
}

output "vm_dns" {
  value = aws_instance.vm.public_dns
}

output "aws_windows_password" {
  value = base64decode(aws_instance.vm.password_data)
}
