# create cloud router for nat gateway
resource "google_compute_router" "router" {
  project = var.project_id
  network = google_compute_network.vpc.id
  region  = var.region
  name    = "nat-router"
}

