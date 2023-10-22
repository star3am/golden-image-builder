data "google_compute_subnetwork" "vm" {
  project = var.gcp_project_id
  name    = "default"
}

data "template_file" "vm" {
  template = file("${path.module}/../../modules/shared/startup_script")
  vars = {
    VM_IP = google_compute_address.vm.address
  }
}

data "google_compute_image" "latest" {
  family = var.source_image_family
}
