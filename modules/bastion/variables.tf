variable "project" {
  description = "Name of the GCP project where the components will be deployed"
  type        = string
}

variable "region" {
  description = "Name of the region where the components will be deployed"
  type        = string
}

variable "zone" {
  description = "The zone where the components will be deployed"
  type        = string
}

variable "members" {
  description = "Users / Service Accounts / groups that can ssh to the bastion via IAP"
  default     = []
}

variable "instance" {
  description = "Name of the instance to be deployed"
  type        = string
  default     = "gke-vm"
}

variable "machine_type" {
  description = "Name of the instance to be deployed"
  type        = string
  default     = "e2-micro"
}

variable "source_image_family" {
  description = "Linux os family to be installed in the instance"
  type        = string
  default     = "debian-11"
}

variable "source_image_project" {
  description = "Linux project that the os to be installed belongs to"
  type        = string
  default     = "debian-cloud"
}

variable "sa_email" {
  description = "Service account emails associated with the instances to allow SSH from IAP"
  type        = string
}

variable "network" {
  description = "The Network where the bastion host resides in"
  type        = string
}

variable "subnetwork" {
  description = "The sub network where the bastion host resides in"
  type        = string
}