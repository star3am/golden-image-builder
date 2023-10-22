## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws)

- <a name="provider_null"></a> [null](#provider\_null)

- <a name="provider_template"></a> [template](#provider\_template)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_eip.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) (resource)
- [aws_eip_association.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) (resource)
- [aws_iam_instance_profile.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) (resource)
- [aws_iam_role.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) (resource)
- [aws_iam_role_policy.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) (resource)
- [aws_instance.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) (resource)
- [aws_key_pair.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) (resource)
- [aws_security_group.vm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (resource)
- [aws_security_group_rule.whitelist_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) (resource)
- [null_resource.vm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [template_file.vm](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_aws_ami_id"></a> [aws\_ami\_id](#input\_aws\_ami\_id)

Description: n/a

Type: `any`

### <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type)

Description: n/a

Type: `any`

### <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region)

Description: n/a

Type: `any`

### <a name="input_aws_windows_instance"></a> [aws\_windows\_instance](#input\_aws\_windows\_instance)

Description: n/a

Type: `any`

### <a name="input_deploy_to_aws"></a> [deploy\_to\_aws](#input\_deploy\_to\_aws)

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

### <a name="output_aws_windows_password"></a> [aws\_windows\_password](#output\_aws\_windows\_password)

Description: n/a

### <a name="output_vm_ip"></a> [vm\_ip](#output\_vm\_ip)

Description: n/a
