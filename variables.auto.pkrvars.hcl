# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.

skip_create_image = false
build_directory = "./output"
cpus   = "2"
memory = "512"
disk_size  = "10240"
aws_region = "ap-southeast-2"
aws_instance_type = "t2.medium"
azure_resource_group = "resourcegroup" # "${env("AZURE_RESOURCE_GROUP")}"
azure_shared_image_gallery = "SharedImageGallery" # "${env("AZURE_SHARED_IMAGE_GALLERY")}"
azure_region = "Australia East"
gcp_zone     = "australia-southeast1-a"
