resource "google_compute_address" "my_internal_ip_addr" {
  project      = var.project_id
  address_type = "INTERNAL"
  region       = var.region
  subnetwork   = google_compute_subnetwork.subnet.id
  name         = "my-ip"
  address      = "10.10.0.7"
  description  = "An internal IP address for my jump host"
}

resource "google_compute_instance" "default" {
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
  name         = "jump-host"

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id
    network_ip = google_compute_address.my_internal_ip_addr.address
  }

}