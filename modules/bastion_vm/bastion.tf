##############
# Bastion VM #
##############

module "bastion" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-vm?ref=v29.0.0"
  project_id = var.project_id
  zone       = var.compute_zone
  name       = var.bastion_name
  tags       = var.tags

  instance_type = var.instance_type

  metadata = {
    block-project-ssh-keys = false
    startup-script         = file("${path.module}/startup_script.sh")
    enable-oslogin         = var.enable_oslogin
  }

  shielded_config = {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  boot_disk = {
    initialize_params = {
      image = data.google_compute_image.debian_image.self_link
      size  = var.boot_disk_size
    }
  }

  network_interfaces = [{
    network    = data.google_compute_network.bastion_network.id
    subnetwork = data.google_compute_subnetwork.bastion_subnetwork.id
  }]

  service_account = {
    email  = module.bastion_service_account.email
    scopes = ["cloud-platform"]
  }
}

module "iap_tunnelling" {
  source                     = "terraform-google-modules/bastion-host/google//modules/iap-tunneling"
  fw_name_allow_ssh_from_iap = "allow-ssh-from-iap-to-tunnel"
  project                    = var.project_id
  network                    = var.bastion_network

  service_accounts = [module.bastion_service_account.email]
  instances = [{
    name = var.bastion_name
    zone = var.compute_zone
  }]

  members = var.members
}
