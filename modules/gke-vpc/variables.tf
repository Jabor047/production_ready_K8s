variable "project" {
  description = "The project in which to create the resources."
  type        = string
}

variable "region" {
  description = "The region in which to create the resources."
  default     = "europe-west2"
  type        = string
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