locals {
  source_image = var.source_image == "latest" ? data.google_compute_image.latest.id : var.source_image
}
