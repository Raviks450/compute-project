variable "project-id" {}

variable "google_creds" {
  description = "GCP Service Account JSON credentials"
  type        = string
  sensitive   = true
}
