## Providers

The following providers are used by this module:

- <a name="provider_external"></a> [external](#provider_external) (2.3.4)

- <a name="provider_null"></a> [null](#provider_null) (3.2.4-alpha.2)

## Modules

The following Modules are called:

### <a name="module_awx_ansible_tower"></a> [awx_ansible_tower](#module_awx_ansible_tower)

Source: github.com/star3am/terraform-hashicorp-hashiqube.git

Version: master

## Resources

The following resources are used by this module:

- [null_resource.awx_cli](https://registry.terraform.io/providers/hashicorp/null/3.2.4-alpha.2/docs/resources/resource) (resource)
- [external_external.tower_token](https://registry.terraform.io/providers/hashicorp/external/2.3.4/docs/data-sources/external) (data source)

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

The following input variables are optional (have default values):

### <a name="input_call_ansible_via_terraform"></a> [call_ansible_via_terraform](#input_call_ansible_via_terraform)

Description: Call Ansible via Terraform

Type: `bool`

Default: `false`

### <a name="input_tower_cli_local"></a> [tower_cli_local](#input_tower_cli_local)

Description: Location of awx tower cli utility

Type: `string`

Default: `"/home/vagrant/.local/bin/awx"`

### <a name="input_tower_cli_remote"></a> [tower_cli_remote](#input_tower_cli_remote)

Description: Location of awx tower cli utility

Type: `string`

Default: `"~/.local/bin/awx"`

### <a name="input_tower_host"></a> [tower_host](#input_tower_host)

Description: The Tower host endpoint

Type: `string`

Default: `"http://localhost:8043/"`

### <a name="input_tower_password"></a> [tower_password](#input_tower_password)

Description: Tower password

Type: `string`

Default: `"password"`

## Outputs

The following outputs are exported:

### <a name="output_awx_ansible_tower_ip_address"></a> [awx_ansible_tower_ip_address](#output_awx_ansible_tower_ip_address)

Description: AWX Tower IP address
