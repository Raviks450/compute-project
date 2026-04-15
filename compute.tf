# compute/main.tf
# 📥 Read outputs from Network project state
data "terraform_remote_state" "network" {
  backend = "remote"
  config = {
    organization = "Ravi-Terraform450"
    workspaces {
         name = "network-project"
    }
  }
}

# Use the values from Project A
resource "google_compute_instance" "vm" {
  project      = var.project-id
  name         = "my-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    # ✅ Using VPC & Subnet from Project A's state
    network    = data.terraform_remote_state.network.outputs.vpc_id
    subnetwork = data.terraform_remote_state.network.outputs.subnet_id
    access_config {}
  }
}
