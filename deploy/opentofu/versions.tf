terraform {
  required_version = ">= 1.6"
  backend "gcs" {
    bucket = "zach-training-area-tfstate"
    prefix = "devops-todo"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Local state for now — fine while it's just you, on your machine.
  # Once more than one person/machine touches this, move to a GCS backend
  # so state isn't just a file on your laptop.
}

provider "google" {
  project = var.project_id
  region  = var.region
}
