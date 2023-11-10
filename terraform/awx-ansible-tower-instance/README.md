## Providers

No providers.

## Modules

The following Modules are called:

### <a name="module_awx_ansible_tower"></a> [awx_ansible_tower](#module_awx_ansible_tower)

Source: github.com/star3am/terraform-hashicorp-hashiqube.git

Version: riaan

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_ssh_private_key"></a> [ssh_private_key](#input_ssh_private_key)

Description: Content of your SSH private key, matching the public key above

Type: `string`

### <a name="input_ssh_public_key"></a> [ssh_public_key](#input_ssh_public_key)

Description: Content of your SSH public key, matching the private key below

Type: `string`

### <a name="input_use_packer_image"></a> [use_packer_image](#input_use_packer_image)

Description: Use your Packer build image

Type: `bool`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_awx_ansible_tower_ip_address"></a> [awx_ansible_tower_ip_address](#output_awx_ansible_tower_ip_address)

Description: AWX Tower IP address
