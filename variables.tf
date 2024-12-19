variable "project" {
  description = "The project ID to deploy resources."
}

variable "region" {
  description = "The region in which to create the resources."
  default     = "europe-west2"
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster."
  default     = "gke-cluster"
}

variable "gke_vpc_subnet_cidr" {
  description = "The CIDR range for the GKE VPC subnet."
  type        = string
}

variable "gke_ip_range_pods" {
  description = "The CIDR range for the GKE pods."
  type        = string
}

variable "gke_ip_range_services" {
  description = "The CIDR range for the GKE services."
  type        = string
}

variable "master_auth_subnet_cidr" {
  description = "The CIDR range for the GKE master auth subnet."
  type        = string
}

variable "zones" {
  description = "The zones in which to create the resources."
  type        = list(string)
}

variable "authorized_sources_ranges" {
  description = "The authorized sources ranges for the GKE master."
  type        = map(string)

}

variable "gke_master_ipv4_cidr_block" {
  description = "The CIDR range for the GKE master."
  type        = string
}
# variable "environment" {
#   description = "The environment in which the resources are deployed."
# }

variable "service_accounts" {
  description = "(Optional) Service accounts to be created in the project"
  type = map(object({
    display_name                    = string
    roles                           = optional(list(string))
    service_accounts_to_impersonate = optional(map(map(list(string))))
  }))
  default = {}
}

variable "compute_zone" {
  description = "The zone to deploy the VM in"
  type        = string
  default     = "europe-west2-c"
}

variable "service_account_create" {
  description = "Create service account. When set to false, uses a data source to reference an existing service account"
  type        = bool
  default     = false
}

variable "bastion_vm_sa_name" {
  description = "The name of the service account to be used with the VM"
  type        = string
}

variable "enable_oslogin" {
  description = "The ability to control access to the VM instances based on IAM permissions (e.g., for ssh)"
  type        = string
  default     = ""
}

variable "bastion_name" {
  description = "The name of the VM"
  type        = string
}

variable "members" {
  description = "Users / Service Accounts / groups that can ssh to the bastion via IAP"
  default     = []
}

# variable "bastion_ip" {
#   description = "The static IP within the subnetwork to assign to the VM"
#   type        = string
# }
