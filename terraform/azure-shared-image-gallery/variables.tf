variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create the virtual network."
  default     = "resourcegroup"
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "Australia East"
}

variable "custom_image_gallery_name" {
  type        = string
  default     = "SharedImageGallery"
  description = "Share image gallery name"
}

variable "custom_image_publisher" {
  type        = string
  default     = "RiaanNolan"
  description = "Image publisher name"
}
