output "network_name" {
  value = google_compute_network.gke-vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.gke-vpc-subnet.name
}