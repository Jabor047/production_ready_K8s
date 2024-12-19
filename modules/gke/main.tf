resource "google_container_cluster" "gke" {
  name               = var.gke_cluster_name
  location           = var.region
  node_locations     = var.zones
  network            = var.network_name
  subnetwork         = var.subnet_name
  enable_autopilot   = false
  initial_node_count = 1
  deletion_protection = false

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = lookup(var.authorized_sources_ranges, "cidr_block", "")
      display_name = lookup(var.authorized_sources_ranges, "display_name", "")
    }
  }

  release_channel {
    channel = "REGULAR"
  }

}