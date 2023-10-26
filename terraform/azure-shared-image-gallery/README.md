## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) (~> 3.57)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_shared_image.centos79](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.centos83](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.redhat79](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.redhat83](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.ubuntu1804](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.ubuntu2004](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.ubuntu2204](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.windows2016](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.windows2019](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image.windows2022](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) (resource)
- [azurerm_shared_image_gallery.sig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_custom_image_gallery_name"></a> [custom_image_gallery_name](#input_custom_image_gallery_name)

Description: Share image gallery name

Type: `string`

Default: `"SharedImageGallery"`

### <a name="input_custom_image_publisher"></a> [custom_image_publisher](#input_custom_image_publisher)

Description: Image publisher name

Type: `string`

Default: `"RiaanNolan"`

### <a name="input_location"></a> [location](#input_location)

Description: The location/region where the virtual network is created. Changing this forces a new resource to be created.

Type: `string`

Default: `"Australia East"`

### <a name="input_resource_group"></a> [resource_group](#input_resource_group)

Description: The name of the resource group in which to create the virtual network.

Type: `string`

Default: `"resourcegroup"`

## Outputs

No outputs.
