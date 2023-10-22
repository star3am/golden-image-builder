# https://www.terraform.io/docs/providers/google/r/compute_instance.html
# https://github.com/terraform-providers/terraform-provider-google/blob/master/examples/internal-load-balancing/main.tf

resource "null_resource" "vm" {
  triggers = {
    my_ipaddress   = var.my_ipaddress
    ssh_public_key = var.ssh_public_key
  }
}

resource "google_compute_region_instance_group_manager" "vm" {
  name                      = "vm"
  provider                  = google
  base_instance_name        = var.gcp_cluster_name
  region                    = var.gcp_region
  distribution_policy_zones = var.gcp_zones
  version {
    name              = var.gcp_cluster_name
    instance_template = google_compute_instance_template.vm.self_link
  }
  target_size = var.gcp_cluster_size
  depends_on  = [google_compute_instance_template.vm]
  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 3
    max_unavailable_fixed = 0
  }
}

resource "google_compute_instance_template" "vm" {
  provider             = google
  name_prefix          = var.gcp_cluster_name
  description          = var.gcp_cluster_description
  instance_description = var.gcp_cluster_description
  machine_type         = var.gcp_machine_type
  tags                 = var.gcp_cluster_tags
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  disk {
    boot         = true
    auto_delete  = true
    source_image = local.source_image
    disk_size_gb = var.gcp_root_volume_disk_size_gb
    disk_type    = var.gcp_root_volume_disk_type
  }
  metadata_startup_script = data.template_file.vm.rendered
  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.vm.self_link
    access_config {
      nat_ip = google_compute_address.vm.address
    }
  }
  service_account {
    email  = google_service_account.vm.email
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_address" "vm" {
  name = "hashiqube"
}

resource "google_compute_firewall" "my_ipaddress" {
  name    = "${var.gcp_cluster_name}-my-ipaddress"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = ["${var.my_ipaddress}/32"]
}

resource "google_compute_firewall" "whitelist_cidr" {
  for_each = var.whitelist_cidr

  name    = "whitelist-cidr-${each.key}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [each.value]
}

resource "google_service_account" "vm" {
  account_id   = var.gcp_account_id
  display_name = "vm"
}

resource "google_project_iam_member" "vm" {
  project = var.gcp_project_id
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${google_service_account.vm.email}"
}
