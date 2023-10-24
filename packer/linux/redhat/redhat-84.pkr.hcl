# Hashicorp Packer
#
# https://www.packer.io/
#

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "azure-arm" "redhat-84" {
  client_id     = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  #tenant_id                         = "${var.azure_tenant_id}"
  subscription_id                   = "${var.azure_subscription_id}"
  image_offer                       = "RHEL"
  image_publisher                   = "RedHat"
  image_sku                         = "8-lvm-gen2"
  image_version                     = "latest"
  managed_image_name                = "redhat-8"
  location                          = "${var.azure_region}"
  managed_image_resource_group_name = "resourcegroup"
  os_type                           = "linux"
  vm_size                           = "Standard_DS2_v2"
  shared_image_gallery_destination {
    gallery_name        = "SharedImageGallery"
    image_name          = "redhat-84"
    image_version       = "${local.azure_version_number}"
    replication_regions = ["${var.azure_region}"]
    resource_group      = "resourcegroup"
  }
  azure_tags = {
    vm_name = "redhat-84"
  }
}

source "amazon-ebs" "redhat-84" {
  source_ami_filter {
    most_recent = true
    owners      = ["amazon", "aws-marketplace", "self", "309956199498"]
    filters = {
      name         = "RHEL-8.4.0_HVM*"
      architecture = "x86_64"
    }
  }
  // access_key    = "${var.aws_access_key}"
  // secret_key    = "${var.aws_secret_key}"
  // region        = "${var.aws_region}"
  instance_type = "${var.aws_instance_type}"
  ssh_username  = "ec2-user"
  ami_name      = "redhat-84-${local.version_number}"
  tags = {
    vm_name = "redhat-84"
  }
}

source "googlecompute" "redhat-84" {
  project_id          = "${var.gcp_project_id}"
  account_file        = "${var.gcp_account_file}"
  disk_size           = "${var.disk_size}"
  image_name          = "redhat-84-${local.version_number}"
  source_image_family = "rhel-8"
  ssh_username        = "packer"
  zone                = "${var.gcp_zone}"
  image_labels = {
    vm_name = "redhat-84"
  }
  image_family = "soe-rhel-84"
}

source "vagrant" "redhat-84" {
  source_path     = "generic/rhel8"
  provider        = "virtualbox"
  teardown_method = "suspend"
  skip_package    = true
  communicator    = "ssh"
  box_name        = "redhat-84"
  output_dir      = "${var.build_directory}/redhat-84/vagrant"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vagrant.redhat-84", "source.azure-arm.redhat-84", "source.amazon-ebs.redhat-84", "source.googlecompute.redhat-84"]

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
    playbook_file = "./ansible/roles/ansible-role-example-role/site.yml"
  }

  // provisioner "ansible" {
  //   command = "./packer/scripts/ansible.sh"
  //   # https://www.packer.io/docs/provisioners/ansible/ansible#redhat-centos
  //   sftp_command = "/usr/libexec/openssh/sftp-server -e"
  //   extra_arguments = [
  //     #"-v",
  //     "--extra-vars",
  //     "disable_epel_repo=false rhel8cis_selinux_state=permissive system_is_ec2=true rhel8cis_rule_1_2_5=false rhel8cis_rule_6_2_12=false"
  //   ]
  //   host_alias    = "none"
  //   playbook_file = "./ansible/roles/RHEL8-CIS/site.yml"
  // }

  provisioner "shell-local" {
    inline = ["curl -s https://api.ipify.org/?format=none"]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline_shebang  = "/bin/sh -x"
    only            = ["azure-arm.redhat-84"]
  }
}
