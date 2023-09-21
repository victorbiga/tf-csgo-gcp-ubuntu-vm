#########################
## GCP Linux VM - Main ##
#########################

# Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 4
}

# Bootstrapping Script to Install Apache
locals {
  commands_template = templatefile("${path.module}/commands.tpl", {})
}

# Create VM
resource "google_compute_instance" "vm_instance_public" {
  name         = "${lower(var.company)}-${lower(var.app_name)}-${var.environment}-vm${random_id.instance_id.hex}"
  machine_type = var.linux_instance_type
  zone         = var.gcp_zone
  hostname     = "${var.app_name}-vm${random_id.instance_id.hex}.${var.app_domain}"
  tags         = ["ssh","tcp","udp"]

  boot_disk {
    initialize_params {
      image = var.ubuntu_pro_2204_sku
      size  = 50 
    }
  }

  metadata_startup_script = local.commands_template

  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.network_subnet.name
    access_config { }
  }
}

###########################
## GCP Linux VM - Output ##
###########################

output "vm-name" {
  value = google_compute_instance.vm_instance_public.name
}

output "vm-external-ip" {
  value = google_compute_instance.vm_instance_public.network_interface.0.access_config.0.nat_ip
}

output "vm-internal-ip" {
  value = google_compute_instance.vm_instance_public.network_interface.0.network_ip
}
