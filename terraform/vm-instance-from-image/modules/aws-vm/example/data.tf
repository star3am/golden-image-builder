data "external" "myipaddress" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

data "aws_ami" "latest" {
  owners      = ["self"]
  most_recent = true
  name_regex  = "^${var.source_ami_prefix}-.*$"
}
