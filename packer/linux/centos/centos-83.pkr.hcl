# Hashicorp Packer
#
# https://www.packer.io/
#

packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 1"
    }
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "azure-arm" "centos-83" {
  client_id     = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  #tenant_id                         = "${var.azure_tenant_id}"
  subscription_id                   = "${var.azure_subscription_id}"
  image_offer                       = "CentOS-LVM"
  image_publisher                   = "OpenLogic"
  image_sku                         = "8-lvm-gen2"
  image_version                     = "latest"
  managed_image_name                = "centos-8"
  location                          = "${var.azure_region}"
  managed_image_resource_group_name = "resourcegroup"
  os_type                           = "linux"
  vm_size                           = "Standard_DS2_v2"
  shared_image_gallery_destination {
    gallery_name        = "SharedImageGallery"
    image_name          = "centos-83"
    image_version       = "${local.azure_version_number}"
    replication_regions = ["${var.azure_region}"]
    resource_group      = "resourcegroup"
  }
  azure_tags = {
    vm_name = "centos-83"
  }
}

source "amazon-ebs" "centos-83" {
  source_ami_filter {
    most_recent = true
    owners      = ["amazon", "aws-marketplace", "self", "374168611083"]
    filters = {
      name         = "*CentOS_8*"
      architecture = "x86_64"
    }
  }
  access_key    = "${var.aws_access_key}"
  secret_key    = "${var.aws_secret_key}"
  region        = "${var.aws_region}"
  instance_type = "${var.aws_instance_type}"
  ssh_username  = "centos"
  ami_name      = "centos-83-${local.version_number}"
  tags = {
    vm_name = "centos-83"
  }
}

source "googlecompute" "centos-83" {
  project_id          = "${var.gcp_project_id}"
  account_file        = "${var.gcp_account_file}"
  disk_size           = "${var.disk_size}"
  image_name          = "centos-83-${local.version_number}"
  source_image_family = "centos-8"
  ssh_username        = "packer"
  zone                = "${var.gcp_zone}"
  image_labels = {
    vm_name = "centos-83"
  }
  image_family = "soe-centos-83"
}

source "vagrant" "centos-83" {
  source_path     = "bento/centos-8.3"
  provider        = "virtualbox"
  teardown_method = "suspend"
  skip_package    = true
  communicator    = "ssh"
  box_name        = "centos-83"
  output_dir      = "${var.build_directory}/centos-83/vagrant"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vagrant.centos-83", "source.azure-arm.centos-83", "source.amazon-ebs.centos-83", "source.googlecompute.centos-83"]

  provisioner "shell" {
    inline = ["cat /etc/os-release"]
  }

  provisioner "ansible" {
    command = "./packer/scripts/ansible.sh"
    # https://www.packer.io/docs/provisioners/ansible/ansible#redhat-centos
    sftp_command = "/usr/libexec/openssh/sftp-server -e"
    extra_arguments = [
      #"-v",
      "--extra-vars", "ansible_become=true version_number=${local.version_number}"
    ]
    host_alias    = "none"
    playbook_file = "./ansible/ansible-role-example-role/site.yml"
  }

  provisioner "ansible" {
    command = "./packer/scripts/ansible.sh"
    # https://www.packer.io/docs/provisioners/ansible/ansible#redhat-centos
    sftp_command = "/usr/libexec/openssh/sftp-server -e"
    extra_arguments = [
      #"-v",
      "--extra-vars", "rhel8cis_selinux_state=permissive rhel8cis_rule_6_2_12=false"
    ]
    host_alias    = "none"
    playbook_file = "./ansible/roles/RHEL8-CIS/site.yml"
  }

  provisioner "shell-local" {
    inline = ["curl -s https://api.ipify.org/?format=none"]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline_shebang  = "/bin/sh -x"
    only            = ["azure-arm.centos-83"]
  }
}
