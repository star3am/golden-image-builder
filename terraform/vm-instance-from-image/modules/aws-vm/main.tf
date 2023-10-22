# https://www.terraform.io/docs/providers/aws/r/instance.html

data "aws_ami" "latest" {
  owners      = ["self"]
  most_recent = true
  name_regex  = "^${var.source_ami_prefix}-.*$"
}

resource "null_resource" "vm" {
  triggers = {
    my_ipaddress   = var.my_ipaddress
    ssh_public_key = var.ssh_public_key
  }
}

resource "aws_iam_role" "vm" {
  name               = "vm"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "vm" {
  name = "vm"
  role = aws_iam_role.vm.name
}

resource "aws_iam_role_policy" "vm" {
  name   = "vm"
  role   = aws_iam_role.vm.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

data "template_file" "vm" {
  template = file("${path.module}/../../modules/shared/startup_script")
  vars = {
    VM_USERNAME = var.vm_username
    VM_PASSWORD = var.vm_password
  }
}

resource "aws_instance" "vm" {
  ami                         = var.aws_ami_id == "latest" ? data.aws_ami.latest.id : var.aws_ami_id
  associate_public_ip_address = true
  instance_type               = var.aws_instance_type
  security_groups             = [aws_security_group.vm.name]
  key_name                    = aws_key_pair.vm.key_name
  user_data_base64            = var.is_windows ? base64gzip(data.template_file.vm.rendered) : base64gzip(data.template_file.vm.rendered)
  iam_instance_profile        = aws_iam_instance_profile.vm.name
  /* get_password_data           = var.is_windows ? true : null */
  tags = {
    Name = "vm"
  }
}

# TODO: needs further work
#resource "null_resource" "aws_windows_password" {
#  triggers = {
#    aws_windows_password = base64decode(aws_instance.vm.password_data)
#  }
#}

resource "aws_key_pair" "vm" {
  key_name   = "vm"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "vm" {
  name = "vm"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ipaddress}/32"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  dynamic "ingress" {
    for_each = var.whitelist_cidr

    content {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  timestamp = timestamp()
}

resource "null_resource" "awx_cli" {
  triggers = {
    timestamp = local.timestamp
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../modules/shared"
    command     = "/bin/bash tower_callback_script"

    environment = {
      TOWER_HOST           = var.tower_host
      TOWER_USERNAME       = var.tower_username
      TOWER_PASSWORD       = var.tower_password
      VM_PUBLIC_IP_ADDRESS = aws_instance.vm.public_ip
      VM_NAME              = "vm"
    }
  }

  depends_on = [
    aws_instance.vm
  ]
}
