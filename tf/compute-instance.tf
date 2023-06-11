resource "google_compute_address" "my_internal_ip_addr" {
  project      = var.project_id
  address_type = "INTERNAL"
  region       = var.region
  subnetwork   = google_compute_subnetwork.subnet.id
  name         = "my-ip"
  address      = var.internal_ip
  description  = "An internal IP address for my jump host"
}

resource "google_compute_instance" "jumphost" {
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
  name         = "jump-host"

  metadata_startup_script = <<-EOT
    #!/bin/bash
    ## Add the gcloud CLI distribution URI as a package source && install google-cli
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo -y

    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

    sudo apt-get update && sudo apt-get install google-cloud-cli -y

    ## install gke-gcloud-auth-plugin
    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y

    ## install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  EOT

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