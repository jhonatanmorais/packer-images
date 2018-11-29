# Set provider and terraform version

provider "google" {
  project     = "${var.project}"
  region      = "${var.location}"
  credentials = "${file("/root/.gcp/credentials.json")}"
}

terraform {
  required_version = "0.11.7"
}

resource "google_compute_instance" "tester_vm" {
  name         = "tester-vm"
  machine_type = "n1-standard-1"
  zone         = "${var.location}"

  boot_disk {
    initialize_params {
      image = "projects/blackops-qa/global/images/neoway-image-${var.travis_build_id}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

}
