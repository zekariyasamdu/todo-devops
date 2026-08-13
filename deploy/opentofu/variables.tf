variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region for all resources"
  default     = "africa-south1"
}

variable "repository_id" {
  type        = string
  description = "Artifact Registry repository name"
  default     = "training"
}

variable "image_tag" {
  type        = string
  description = "Tag of the image to deploy"
  default     = "latest"
}

variable "db_name" {
  default = "devops_todo"
}

variable "db_user" {
  default = "zach"
}


