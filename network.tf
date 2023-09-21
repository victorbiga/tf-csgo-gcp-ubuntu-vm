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
resource "google_compute_firewall" "allow-tcp" {
  name    = "${var.app_name}-${var.environment}-fw-allow-tcp"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["27015"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["tcp"]
}

# allow https
resource "google_compute_firewall" "allow-udp" {
  name    = "${var.app_name}-${var.environment}-fw-allow-udp"
  network = google_compute_network.vpc.name
  allow {
    protocol = "udp"
    ports    = ["27015"]
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
