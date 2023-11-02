# Hashicorp Packer
#
# https://www.packer.io/
#

source "azure-arm" "debian-79" {
  client_id     = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  #tenant_id                         = "${var.azure_tenant_id}"
  subscription_id                   = "${var.azure_subscription_id}"
  image_offer                       = "CentOS-LVM"
  image_publisher                   = "OpenLogic"
  image_sku                         = "7-lvm-gen2"
  image_version                     = "latest"
  managed_image_name                = "centos-7"
  location                          = "${var.azure_region}"
  managed_image_resource_group_name = "resourcegroup"
  os_type                           = "linux"
  vm_size                           = "Standard_DS2_v2"
  shared_image_gallery_destination {
    gallery_name        = "SharedImageGallery"
    image_name          = "centos-79"
    image_version       = "${local.azure_version_number}"
    replication_regions = ["${var.azure_region}"]
    resource_group      = "resourcegroup"
  }
  azure_tags = {
    vm_name = "${var.vm_name}"
  }
}

source "amazon-ebs" "centos-79" {
  access_key    = "${var.aws_access_key}"
  secret_key    = "${var.aws_secret_key}"
  region        = "${var.aws_region}"
  source_ami    = "${var.aws_source_ami}"
  instance_type = "${var.aws_instance_type}"
  ssh_username  = "centos"
  ami_name      = "${var.vm_name}-${local.version_number}"
  tags = {
    vm_name = "${var.vm_name}"
  }
}

source "googlecompute" "centos-79" {
  project_id          = "${var.gcp_project_id}"
  account_file        = "${var.gcp_account_file}"
  disk_size           = "${var.disk_size}"
  image_name          = "${var.vm_name}-${local.version_number}"
  source_image_family = "centos-7"
  ssh_username        = "packer"
  zone                = "${var.gcp_zone}"
  image_labels = {
    vm_name = "${var.vm_name}"
  }
  image_family = "debain-10"
}

source "vagrant" "centos-79" {
  add_force       = true
  add_clean       = true
  source_path     = "bento/centos-7.9"
  provider        = "virtualbox"
  teardown_method = "destroy"
  communicator    = "ssh"
  box_name        = "${var.vm_name}"
  output_dir      = "${var.build_directory}/vagrant"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.azure-arm.centos-79", "source.vagrant.centos-79", "source.amazon-ebs.centos-79", "source.googlecompute.centos-79"]

  provisioner "shell" {
    inline = ["cat /etc/os-release"]
  }

  provisioner "ansible" {
    command         = "./packer/scripts/ansible.sh"
    extra_arguments = ["-v", "--extra-vars", "ansible_remote_tmp=/tmp"]
    host_alias      = "none"
    playbook_file   = "./ansible/ansible-role-example-role/site.yml"
  }

  provisioner "ansible" {
    command         = "./packer/scripts/ansible.sh"
    extra_arguments = ["-v", "--extra-vars", "ansible_remote_tmp=/tmp rhel7cis_selinux_state=permissive rhel7cis_rule_6_2_12=false"]
    host_alias      = "none"
    playbook_file   = "./ansible/RHEL7-CIS/site.yml"
  }

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
