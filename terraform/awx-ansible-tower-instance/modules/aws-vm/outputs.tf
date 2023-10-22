//output "vm_eip" {
//  value = aws_eip.vm.public_ip
//}

output "vm_ip" {
  value = aws_instance.vm.public_ip
}

output "vm_dns" {
  value = aws_instance.vm.public_dns
}
