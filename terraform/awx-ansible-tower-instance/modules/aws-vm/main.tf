# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "null_resource" "vm" {
  triggers = {
    my_ipaddress   = var.my_ipaddress
    ssh_public_key = var.ssh_public_key
  }
}

resource "aws_iam_role" "vm" {
  name               = "awx-vm"
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
  name = "awx-vm"
  role = aws_iam_role.vm.name
}

resource "aws_iam_role_policy" "vm" {
  name   = "awx-vm"
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
    TOWER_USERNAME = var.tower_username
    TOWER_PASSWORD = var.tower_password
  }
}

resource "aws_instance" "vm" {
  ami                         = var.aws_ami_id
  associate_public_ip_address = true
  instance_type               = var.aws_instance_type
  security_groups             = [aws_security_group.vm.name]
  key_name                    = aws_key_pair.vm.key_name
  user_data_base64            = base64gzip(data.template_file.vm.rendered)
  iam_instance_profile        = aws_iam_instance_profile.vm.name
  root_block_device {
    encrypted   = false
    volume_size = 30
  }
  tags = {
    Name = "awx-vm"
  }
}

resource "aws_key_pair" "vm" {
  key_name   = "awx-vm"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "vm" {
  name = "awx-vm"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ipaddress}/32"]
  }
  ingress {
    from_port   = 8043
    to_port     = 8043
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

resource "aws_security_group_rule" "vm" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${aws_instance.vm.public_ip}/32"]
  security_group_id = aws_security_group.vm.id
  depends_on = [
    aws_instance.vm,
    aws_security_group.vm
  ]
}

/*
data "external" "tower_token" {
  program = [
    "/bin/bash", "-c", "${var.tower_cli_local} login --conf.host ${var.tower_host} --conf.insecure --conf.username ${var.tower_username} --conf.password \"${var.tower_password}\""]
}

locals {
  timestamp = timestamp()
}

resource "null_resource" "awx_cli" {
  triggers = {
    timestamp = local.timestamp
  }

  provisioner "remote-exec" {
    inline = [
      "${var.tower_cli_remote} --conf.host ${var.tower_host} -f human job_templates launch 7 --monitor --filter status --conf.insecure --conf.username ${var.tower_username} --conf.password \"${var.tower_password}\"",
    ]

    connection {
      type        = "ssh"
      user        = var.vm_username
      password    = var.vm_password
      host        = aws_instance.vm.public_ip
    }
  }

  provisioner "local-exec" {
    command = "${var.tower_cli_local} --conf.host ${var.tower_host} -f human job_templates launch 7 --monitor --filter status --conf.insecure --conf.username ${var.tower_username} --conf.password \"${var.tower_password}\""
  }
}
*/
