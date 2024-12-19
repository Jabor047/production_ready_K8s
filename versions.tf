terraform {
  required_version = ">=1.9.2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=5.37.0, < 6.0.0"
    }
  }
}