## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_google"></a> [google](#provider\_google)

- <a name="provider_null"></a> [null](#provider\_null)

- <a name="provider_template"></a> [template](#provider\_template)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [google_compute_address.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) (resource)
- [google_compute_firewall.my_ipaddress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) (resource)
- [google_compute_firewall.whitelist_cidr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) (resource)
- [google_compute_instance_template.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) (resource)
- [google_compute_region_instance_group_manager.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager) (resource)
- [google_project_iam_member.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) (resource)
- [google_service_account.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) (resource)
- [null_resource.vm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [google_compute_subnetwork.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) (data source)
- [template_file.vm](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_deploy_to_gcp"></a> [deploy\_to\_gcp](#input\_deploy\_to\_gcp)

Description: n/a

Type: `any`

### <a name="input_gcp_account_id"></a> [gcp\_account\_id](#input\_gcp\_account\_id)

Description: n/a

Type: `any`

### <a name="input_gcp_cluster_description"></a> [gcp\_cluster\_description](#input\_gcp\_cluster\_description)

Description: n/a

Type: `any`

### <a name="input_gcp_cluster_name"></a> [gcp\_cluster\_name](#input\_gcp\_cluster\_name)

Description: n/a

Type: `any`

### <a name="input_gcp_cluster_size"></a> [gcp\_cluster\_size](#input\_gcp\_cluster\_size)

Description: n/a

Type: `any`

### <a name="input_gcp_cluster_tag_name"></a> [gcp\_cluster\_tag\_name](#input\_gcp\_cluster\_tag\_name)

Description: n/a

Type: `any`

### <a name="input_gcp_custom_metadata"></a> [gcp\_custom\_metadata](#input\_gcp\_custom\_metadata)

Description: n/a

Type: `any`

### <a name="input_gcp_machine_type"></a> [gcp\_machine\_type](#input\_gcp\_machine\_type)

Description: n/a

Type: `any`

### <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region)

Description: n/a

Type: `any`

### <a name="input_gcp_root_volume_disk_size_gb"></a> [gcp\_root\_volume\_disk\_size\_gb](#input\_gcp\_root\_volume\_disk\_size\_gb)

Description: n/a

Type: `any`

### <a name="input_gcp_root_volume_disk_type"></a> [gcp\_root\_volume\_disk\_type](#input\_gcp\_root\_volume\_disk\_type)

Description: n/a

Type: `any`

### <a name="input_gcp_zones"></a> [gcp\_zones](#input\_gcp\_zones)

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

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.my_ipaddress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.whitelist_cidr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance_template.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) | resource |
| [google_compute_region_instance_group_manager.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager) | resource |
| [google_project_iam_member.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [null_resource.vm](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [google_compute_image.latest](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_compute_subnetwork.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [template_file.vm](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_to_gcp"></a> [deploy\_to\_gcp](#input\_deploy\_to\_gcp) | n/a | `any` | n/a | yes |
| <a name="input_gcp_account_id"></a> [gcp\_account\_id](#input\_gcp\_account\_id) | n/a | `any` | n/a | yes |
| <a name="input_gcp_cluster_description"></a> [gcp\_cluster\_description](#input\_gcp\_cluster\_description) | n/a | `any` | n/a | yes |
| <a name="input_gcp_cluster_name"></a> [gcp\_cluster\_name](#input\_gcp\_cluster\_name) | n/a | `any` | n/a | yes |
| <a name="input_gcp_cluster_size"></a> [gcp\_cluster\_size](#input\_gcp\_cluster\_size) | n/a | `any` | n/a | yes |
| <a name="input_gcp_cluster_tags"></a> [gcp\_cluster\_tags](#input\_gcp\_cluster\_tags) | n/a | `any` | n/a | yes |
| <a name="input_gcp_custom_metadata"></a> [gcp\_custom\_metadata](#input\_gcp\_custom\_metadata) | n/a | `any` | n/a | yes |
| <a name="input_gcp_machine_type"></a> [gcp\_machine\_type](#input\_gcp\_machine\_type) | n/a | `any` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | n/a | `any` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | n/a | `any` | n/a | yes |
| <a name="input_gcp_root_volume_disk_size_gb"></a> [gcp\_root\_volume\_disk\_size\_gb](#input\_gcp\_root\_volume\_disk\_size\_gb) | n/a | `any` | n/a | yes |
| <a name="input_gcp_root_volume_disk_type"></a> [gcp\_root\_volume\_disk\_type](#input\_gcp\_root\_volume\_disk\_type) | n/a | `any` | n/a | yes |
| <a name="input_gcp_zones"></a> [gcp\_zones](#input\_gcp\_zones) | n/a | `any` | n/a | yes |
| <a name="input_is_windows"></a> [is\_windows](#input\_is\_windows) | n/a | `any` | n/a | yes |
| <a name="input_my_ipaddress"></a> [my\_ipaddress](#input\_my\_ipaddress) | n/a | `any` | n/a | yes |
| <a name="input_source_image"></a> [source\_image](#input\_source\_image) | (Optional) Source image of the VM. | `string` | `"latest"` | no |
| <a name="input_source_image_family"></a> [source\_image\_family](#input\_source\_image\_family) | (Optional) Image family of source image, it's required if source\_image is latest. | `string` | `""` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | n/a | `any` | n/a | yes |
| <a name="input_tower_cli_local"></a> [tower\_cli\_local](#input\_tower\_cli\_local) | n/a | `any` | n/a | yes |
| <a name="input_tower_cli_remote"></a> [tower\_cli\_remote](#input\_tower\_cli\_remote) | n/a | `any` | n/a | yes |
| <a name="input_tower_host"></a> [tower\_host](#input\_tower\_host) | n/a | `any` | n/a | yes |
| <a name="input_tower_password"></a> [tower\_password](#input\_tower\_password) | n/a | `any` | n/a | yes |
| <a name="input_tower_username"></a> [tower\_username](#input\_tower\_username) | n/a | `any` | n/a | yes |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | n/a | `any` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `any` | n/a | yes |
| <a name="input_whitelist_cidr"></a> [whitelist\_cidr](#input\_whitelist\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_ip"></a> [vm\_ip](#output\_vm\_ip) | n/a |
<!-- END_TF_DOCS -->
