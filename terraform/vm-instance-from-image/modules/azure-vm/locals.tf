locals {
  source_image_id = "/subscriptions/${var.subscription_id}/resourceGroups/resourcegroup/providers/Microsoft.Compute/galleries/${var.shared_image_gallery_name}/images/${var.image_definition}/versions/${var.image_version_number}"
  timestamp       = timestamp()
}
