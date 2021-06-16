resource "random_string" "upper" {
  length  = 8
  upper   = false
  lower   = true
  number  = false
  special = false
}
resource "google_compute_instance" "default" {
  name         = "vm-on-premise-vm-terraform"
  machine_type = "e2-small"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

network_interface {
    network = "default"  
  }

metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
resource "google_storage_bucket" "default" {
 name     = "bucket-${random_string.upper.result}"
 storage_class = "MULTI_REGIONAL"
 uniform_bucket_level_access = true
}

