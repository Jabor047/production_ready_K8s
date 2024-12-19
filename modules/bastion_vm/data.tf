############
# VM Image #
############

data "google_compute_image" "debian_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

###########
# Network #
###########

data "google_compute_network" "bastion_network" {
  project = var.project_id
  name    = var.bastion_network
}

data "google_compute_subnetwork" "bastion_subnetwork" {
  project = var.project_id
  region  = "europe-west2"
  name    = var.bastion_subnetwork
}
