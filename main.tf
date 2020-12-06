terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file("terraform-297519-0be2aecac844.json")

  project = "terraform-297519"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "test"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 tags	      = ["foo", "bar"]

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

 }
}