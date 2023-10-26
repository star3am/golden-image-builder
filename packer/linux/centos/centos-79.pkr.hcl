# Hashicorp Packer
#
# https://www.packer.io/
#

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "azure-arm" "centos-79" {
  skip_create_image                 = "${var.skip_create_image}"
  client_id                         = "${var.azure_client_id}"
  client_secret                     = "${var.azure_client_secret}"
  tenant_id                         = "${var.azure_tenant_id}"
  subscription_id                   = "${var.azure_subscription_id}"
  image_offer                       = "CentOS-LVM"
  image_publisher                   = "OpenLogic"
  image_sku                         = "7-lvm-gen2"
  image_version                     = "latest"
  managed_image_name                = "centos-7"
  location                          = "${var.azure_region}"
  managed_image_resource_group_name = "resourcegroup"
  os_type                           = "linux"
  vm_size                           = "${var.azure_instance_type}"
  shared_image_gallery_destination {
    gallery_name        = "SharedImageGallery"
    image_name          = "centos-79"
    image_version       = "${local.azure_version_number}"
    replication_regions = ["${var.azure_region}"]
    resource_group      = "resourcegroup"
  }
  azure_tags = {
    vm_name = "centos-79"
  }
}

source "amazon-ebs" "centos-79" {
  source_ami_filter {
    most_recent = true
    owners      = ["amazon", "aws-marketplace", "self", "374168611083"]
    filters = {
      name         = "*CentOS_7*"
      architecture = "x86_64"
    }
  }
  skip_create_ami = "${var.skip_create_image}"
  access_key      = "${var.aws_access_key}"
  secret_key      = "${var.aws_secret_key}"
  region          = "${var.aws_region}"
  instance_type   = "${var.aws_instance_type}"
  ssh_username    = "centos"
  ami_name        = "centos-79-${local.version_number}"
  tags = {
    vm_name = "centos-79"
  }
}

source "googlecompute" "centos-79" {
  skip_create_image   = "${var.skip_create_image}"
  project_id          = "${var.gcp_project_id}"
  account_file        = "${var.gcp_account_file}"
  disk_size           = "${var.disk_size}"
  image_name          = "centos-79-${local.version_number}"
  source_image_family = "centos-7"
  ssh_username        = "packer"
  zone                = "${var.gcp_zone}"
  image_labels = {
    vm_name = "centos-79"
  }
  image_family = "soe-centos-79"
}

source "vagrant" "centos-79" {
  source_path     = "bento/centos-7.9"
  provider        = "virtualbox"
  teardown_method = "suspend"
  skip_package    = true
  communicator    = "ssh"
  box_name        = "centos-79"
  output_dir      = "${var.build_directory}/centos-79/vagrant"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vagrant.centos-79", "source.azure-arm.centos-79", "source.amazon-ebs.centos-79", "source.googlecompute.centos-79"]

  provisioner "shell" {
    inline = ["cat /etc/os-release"]
  }

  provisioner "ansible" {
    command = "./packer/scripts/ansible.sh"
    user    = "${build.User}"
    # https://www.packer.io/docs/provisioners/ansible/ansible#redhat-centos
    sftp_command = "/usr/libexec/openssh/sftp-server -e"
    extra_arguments = [
      #"-v",
      "--extra-vars", "ansible_become=true version_number=${local.version_number}"
    ]
    host_alias    = "none"
    playbook_file = "./ansible/roles/ansible-role-example-role/site.yml"
  }

  // provisioner "ansible" {
  //   command = "./packer/scripts/ansible.sh"
  //   # https://www.packer.io/docs/provisioners/ansible/ansible#redhat-centos
  //   sftp_command = "/usr/libexec/openssh/sftp-server -e"
  //   extra_arguments = [
  //     #"-v",
  //     "--extra-vars", "rhel7cis_selinux_state=permissive rhel7cis_rule_6_2_12=false"
  //   ]
  //   host_alias    = "none"
  //   playbook_file = "./ansible/roles/RHEL7-CIS/site.yml"
  // }

  provisioner "shell-local" {
    inline = ["curl -s https://api.ipify.org/?format=none"]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline_shebang  = "/bin/sh -x"
    only            = ["azure-arm.centos-79"]
  }
}
