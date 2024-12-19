
resource "google_compute_network" "gke-vpc" {
  name                    = "gke-vpc-network"
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke-vpc-subnet" {
  name                     = "gke-vpc-subnet"
  project                  = var.project
  region                   = var.region
  network                  = google_compute_network.gke-vpc.id
  ip_cidr_range            = var.gke_vpc_subnet_cidr
  private_ip_google_access = true

  secondary_ip_range = [
    {
      ip_cidr_range = var.gke_ip_range_pods
      range_name    = "gke-pods"
    },
    {
      ip_cidr_range = var.gke_ip_range_services
      range_name    = "gke-services"
    }
  ]

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 1
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "gke-vpc-master-auth-subnet" {
  name          = "gke-vpc-master-auth-subnet"
  project       = var.project
  region        = var.region
  network       = google_compute_network.gke-vpc.id
  ip_cidr_range = var.master_auth_subnet_cidr
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 1
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_address" "gke_nat_ip" {
  project = var.project
  region  = var.region
  name    = "gke-nat-ip"
}

resource "google_compute_router" "gke_nat_router" {
  project = var.project
  region  = var.region
  name    = "gke-nat-router"
  network = google_compute_network.gke-vpc.id
}

resource "google_compute_router_nat" "gke_nat" {
  project                            = var.project
  region                             = var.region
  name                               = "gke-nat"
  router                             = google_compute_router.gke_nat_router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.gke_nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.gke-vpc-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_global_address" "gke_ingress" {
  project = var.project
  name    = "gke-ingress"
}

