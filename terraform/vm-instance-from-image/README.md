## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) (~> 3.57)

- <a name="provider_external"></a> [external](#provider_external) (~> 2.3)

- <a name="provider_null"></a> [null](#provider_null) (~> 3.0)

## Modules

The following Modules are called:

### <a name="module_aws_vm"></a> [aws_vm](#module_aws_vm)

Source: ./modules/aws-vm

Version:

### <a name="module_azure_vm"></a> [azure_vm](#module_azure_vm)

Source: ./modules/azure-vm

Version:

### <a name="module_gcp_vm"></a> [gcp_vm](#module_gcp_vm)

Source: ./modules/gcp-vm

Version:

## Resources

The following resources are used by this module:

- [null_resource.check](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) (data source)
- [external_external.myipaddress](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) (data source)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_aws_ami_id"></a> [aws_ami_id](#input_aws_ami_id)

Description: (Optional) Specify the AMI ID, or just use latest to pick the latest AMI ID

Type: `string`

Default: `"latest"`

### <a name="input_aws_instance_type"></a> [aws_instance_type](#input_aws_instance_type)

Description: AWS instance type

Type: `string`

Default: `"t2.medium"`

### <a name="input_aws_region"></a> [aws_region](#input_aws_region)

Description: The region in which all AWS resources will be launched

Type: `string`

Default: `"ap-south-1"`

### <a name="input_azure_instance_type"></a> [azure_instance_type](#input_azure_instance_type)

Description: Azure instance type

Type: `string`

Default: `"Standard_DS2_v2"`

### <a name="input_azure_region"></a> [azure_region](#input_azure_region)

Description: The region in which all Azure resources will be launched

Type: `string`

Default: `"Australia East"`

### <a name="input_deploy_to_aws"></a> [deploy_to_aws](#input_deploy_to_aws)

Description: Deploy VM on AWS

Type: `bool`

Default: `false`

### <a name="input_deploy_to_azure"></a> [deploy_to_azure](#input_deploy_to_azure)

Description: Deploy VM on Azure

Type: `bool`

Default: `false`

### <a name="input_deploy_to_gcp"></a> [deploy_to_gcp](#input_deploy_to_gcp)

Description: Deploy VM on GCP

Type: `bool`

Default: `false`

### <a name="input_deploy_to_vmware"></a> [deploy_to_vmware](#input_deploy_to_vmware)

Description: Deploy VM on VMware

Type: `bool`

Default: `false`

### <a name="input_gcp_account_id"></a> [gcp_account_id](#input_gcp_account_id)

Description: Account ID

Type: `string`

Default: `"sa-consul-compute-prod"`

### <a name="input_gcp_cluster_description"></a> [gcp_cluster_description](#input_gcp_cluster_description)

Description: the description for the cluster

Type: `string`

Default: `"hashiqube"`

### <a name="input_gcp_cluster_name"></a> [gcp_cluster_name](#input_gcp_cluster_name)

Description: Cluster name

Type: `string`

Default: `"hashiqube"`

### <a name="input_gcp_cluster_size"></a> [gcp_cluster_size](#input_gcp_cluster_size)

Description: size of the cluster

Type: `number`

Default: `1`

### <a name="input_gcp_cluster_tags"></a> [gcp_cluster_tags](#input_gcp_cluster_tags)

Description: Cluster tag to apply

Type: `map(string)`

Default:

```json
{
  "Name": "hashiqube"
}
```

### <a name="input_gcp_custom_metadata"></a> [gcp_custom_metadata](#input_gcp_custom_metadata)

Description: A map of metadata key value pairs to assign to the Compute Instance metadata

Type: `map(string)`

Default: `{}`

### <a name="input_gcp_machine_type"></a> [gcp_machine_type](#input_gcp_machine_type)

Description: VM type

Type: `string`

Default: `"n1-standard-1"`

### <a name="input_gcp_project"></a> [gcp_project](#input_gcp_project)

Description: GCP project ID

Type: `string`

Default: `"default"`

### <a name="input_gcp_project_id"></a> [gcp_project_id](#input_gcp_project_id)

Description: Account Project ID

Type: `string`

Default: `"riaannolan-142321"`

### <a name="input_gcp_region"></a> [gcp_region](#input_gcp_region)

Description: The region in which all GCP resources will be launched

Type: `string`

Default: `"australia-southeast1"`

### <a name="input_gcp_root_volume_disk_size_gb"></a> [gcp_root_volume_disk_size_gb](#input_gcp_root_volume_disk_size_gb)

Description: The size, in GB, of the root disk volume on each HashiQube node

Type: `number`

Default: `16`

### <a name="input_gcp_root_volume_disk_type"></a> [gcp_root_volume_disk_type](#input_gcp_root_volume_disk_type)

Description: The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard

Type: `string`

Default: `"pd-standard"`

### <a name="input_gcp_zones"></a> [gcp_zones](#input_gcp_zones)

Description: The zones accross which GCP resources will be launched

Type: `list(string)`

Default:

```json
[
  "australia-southeast1-a",
  "australia-southeast1-b",
  "australia-southeast1-c"
]
```

### <a name="input_image_definition"></a> [image_definition](#input_image_definition)

Description: Azure image definition in shared image gallery

Type: `string`

Default: `"ubuntu-2004"`

### <a name="input_image_version_number"></a> [image_version_number](#input_image_version_number)

Description: The Image Version Number

Type: `string`

Default: `"1970.01.010000"`

### <a name="input_is_windows"></a> [is_windows](#input_is_windows)

Description: Is this a Windows VM?

Type: `bool`

Default: `false`

### <a name="input_shared_image_gallery_name"></a> [shared_image_gallery_name](#input_shared_image_gallery_name)

Description: Name of Azure shared image gallery

Type: `string`

Default: `"SharedImageGallery"`

### <a name="input_source_ami_prefix"></a> [source_ami_prefix](#input_source_ami_prefix)

Description: (Optional) This should match Packer template names e.g ubuntu-2004 or windows-20019

Type: `string`

Default: `"ubuntu-2004"`

### <a name="input_source_image"></a> [source_image](#input_source_image)

Description: The Source Image from Marketplace

Type: `string`

Default: `"latest"`

### <a name="input_source_image_family"></a> [source_image_family](#input_source_image_family)

Description: Image family

Type: `string`

Default: `""`

### <a name="input_ssh_public_key"></a> [ssh_public_key](#input_ssh_public_key)

Description: SSH public key

Type: `string`

Default: `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUOc8QvTGjoLc/8cU4p3iFl0xGfELUkwOYt7/Ze2AEOjeb2fI5UzypQ0k0E9QDBN9KPIt2MLb14KEezpekeOxeWQEccFGJz5dFYoCP+q8UvtXBn8KRsIVd6w3JpVvMbn4oQLNyJH7A2aruP9ysIFsKVnWGHAI5JZY2SmhqWbOHVozZNsDC7Qhyz8l5OD7W8surhm1LVplQ7AP8DfVBfJlfx5rD9571qyl2ExfD9Tix++/u6gEeFNR35SFppvB8JHhVrnSQ4WGa1kutAJRr7bDfyeC8n727p96G+HO3CKcc6A+3KmfsV4NW8hZ4u4RUJjRi/DC2+qMDdKlyQBG81KjJ"`

### <a name="input_tower_cli_local"></a> [tower_cli_local](#input_tower_cli_local)

Description: Path of the AWX CLI utility on the build agent

Type: `string`

Default: `"~/.local/bin/awx"`

### <a name="input_tower_cli_remote"></a> [tower_cli_remote](#input_tower_cli_remote)

Description: Path of the AWX CLI utility on the VM

Type: `string`

Default: `"~/.local/bin/awx"`

### <a name="input_tower_host"></a> [tower_host](#input_tower_host)

Description: Tower AWX Host endpoint

Type: `string`

Default: `"https://13.232.55.64:8043"`

### <a name="input_tower_password"></a> [tower_password](#input_tower_password)

Description: AWX Tower password

Type: `string`

Default: `"aix1rii3Bahshuleikei5y"`

### <a name="input_tower_username"></a> [tower_username](#input_tower_username)

Description: AWX Tower username

Type: `string`

Default: `"admin"`

### <a name="input_vm_password"></a> [vm_password](#input_vm_password)

Description: VM password

Type: `string`

Default: `"aix1rii3Bahshuleikei5y"`

### <a name="input_vm_username"></a> [vm_username](#input_vm_username)

Description: VM username

Type: `string`

Default: `"ubuntu"`

### <a name="input_whitelist_cidr"></a> [whitelist_cidr](#input_whitelist_cidr)

Description: Additional CIDRs to whitelist

Type: `map(string)`

Default:

```json
{
  "1102": "58.161.109.181/32",
  "1103": "1.132.108.175/32",
  "1104": "1.128.107.206/32"
}
```

### <a name="input_windows_admin_password"></a> [windows_admin_password](#input_windows_admin_password)

Description: Windows administrator password, this needs to meet password requirement of Azure VM

Type: `string`

Default: `"P@$$w0rd1234!"`

### <a name="input_windows_admin_username"></a> [windows_admin_username](#input_windows_admin_username)

Description: Windows administrator username

Type: `string`

Default: `"adminuser"`

## Outputs

The following outputs are exported:

### <a name="output_aws_vm_ip"></a> [aws_vm_ip](#output_aws_vm_ip)

Description: VM IP address

### <a name="output_aws_vm_ssh"></a> [aws_vm_ssh](#output_aws_vm_ssh)

Description: Command to SSH to the VM

### <a name="output_aws_windows_password"></a> [aws_windows_password](#output_aws_windows_password)

Description: VM Windows password

### <a name="output_azure_vm_ip"></a> [azure_vm_ip](#output_azure_vm_ip)

Description: VM IP address

### <a name="output_azure_vm_ssh"></a> [azure_vm_ssh](#output_azure_vm_ssh)

Description: Command to SSH to the VM

### <a name="output_gcp_vm_ip"></a> [gcp_vm_ip](#output_gcp_vm_ip)

Description: VM IP address

### <a name="output_gcp_vm_ssh"></a> [gcp_vm_ssh](#output_gcp_vm_ssh)

Description: Command to SSH to the VM

### <a name="output_your_ipaddress"></a> [your_ipaddress](#output_your_ipaddress)

Description: The IP Address of the machine that runs Terraform
