variable "gke_cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "region" {
  description = "The region in which to create the resources."
  default     = "europe-west2"
  type        = string
}

variable "zones" {
  description = "The zones in which to create the resources."
  type        = list(string)
}

variable "network_name" {
  description = "The name of the network."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "gke_master_ipv4_cidr_block" {
  description = "The CIDR range for the GKE master."
  type        = string
}

variable "authorized_sources_ranges" {
  description = "The authorized sources ranges for the GKE master."
  type        = map(string)
}