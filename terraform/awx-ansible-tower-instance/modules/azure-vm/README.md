## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)

- <a name="provider_null"></a> [null](#provider\_null)

- <a name="provider_template"></a> [template](#provider\_template)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) (resource)
- [azurerm_network_interface.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) (resource)
- [azurerm_network_security_group.my_ipaddress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) (resource)
- [azurerm_network_security_group.whitelist_cidr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) (resource)
- [azurerm_public_ip.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) (resource)
- [azurerm_resource_group.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_subnet.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) (resource)
- [azurerm_virtual_network.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [null_resource.vm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [template_file.vm_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_azure_instance_type"></a> [azure\_instance\_type](#input\_azure\_instance\_type)

Description: n/a

Type: `any`

### <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region)

Description: n/a

Type: `any`

### <a name="input_deploy_to_azure"></a> [deploy\_to\_azure](#input\_deploy\_to\_azure)

Description: n/a

Type: `any`

### <a name="input_my_ipaddress"></a> [my\_ipaddress](#input\_my\_ipaddress)

Description: n/a

Type: `any`

### <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key)

Description: n/a

Type: `any`

### <a name="input_whitelist_cidr"></a> [whitelist\_cidr](#input\_whitelist\_cidr)

Description: n/a

Type: `any`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_vm_ip"></a> [vm\_ip](#output\_vm\_ip)

Description: n/a
