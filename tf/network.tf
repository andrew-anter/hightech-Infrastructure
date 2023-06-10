# create cloud router for nat gateway
resource "google_compute_router" "router" {
  project = var.project_id
  network = google_compute_network.vpc.id
  region  = var.region
  name    = "nat-router"
}

## Create Nat Gateway with module

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 1.2"
  project_id = var.project_id
  region     = var.region
  router     = google_compute_router.router.name
  name       = "nat-config"
}
