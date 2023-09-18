####################
## Network - Main ##
####################

# create VPC
resource "google_compute_network" "vpc" {
  name                    = "${lower(var.company)}-${lower(var.app_name)}-${var.environment}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# create public subnet
resource "google_compute_subnetwork" "network_subnet" {
  name          = "${lower(var.company)}-${lower(var.app_name)}-${var.environment}-subnet"
  ip_cidr_range = var.network-subnet-cidr
  network       = google_compute_network.vpc.name
  region        = var.gcp_region
}

###################################
## Network Firewall Rules - Main ##
###################################

# Allow http
resource "google_compute_firewall" "allow-http" {
  name    = "${var.app_name}-${var.environment}-fw-allow-http"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http"]
}

# allow https
resource "google_compute_firewall" "allow-https" {
  name    = "${var.app_name}-${var.environment}-fw-allow-https"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["https"]
}

# allow ssh
resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.app_name}-${var.environment}-fw-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ssh"]
}