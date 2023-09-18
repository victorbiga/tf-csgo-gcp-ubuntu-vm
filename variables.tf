#########################
## GCP Provider - Main ##
#########################

# Define Terraform provider
terraform {
  required_version = "~> 1.0"

  required_providers {
    google = {
      source = "hashicorp/google"
      // version = "4.11.0" # pinning version
    }
  }
}

provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}

##############################
## GCP Provider - Variables ##
##############################

# define GCP project name
variable "gcp_project" {
  type        = string
  description = "GCP project name"
}

# define GCP region
variable "gcp_region" {
  type        = string
  description = "GCP region"
}

# define GCP region
variable "gcp_zone" {
  type        = string
  description = "GCP zone"
}

#########################
## Network - Variables ##
#########################

variable "network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}

#####################
## Ubuntu Versions ##
#####################

variable "ubuntu_1804_sku" {
  type        = string
  description = "SKU for Ubuntu 18.04 LTS"
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}
variable "ubuntu_2004_sku" {
  type        = string
  description = "SKU for Ubuntu 20.04 LTS"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}
variable "ubuntu_pro_1604_sku" {
  type        = string
  description = "SKU for Ubuntu PRO 16.04 LTS"
  default     = "ubuntu-os-pro-cloud/ubuntu-pro-1604-lts"
}
variable "ubuntu_pro_1804_sku" {
  type        = string
  description = "SKU for Ubuntu PRO 18.04 LTS"
  default     = "ubuntu-os-pro-cloud/ubuntu-pro-1804-lts"
}
variable "ubuntu_pro_2004_sku" {
  type        = string
  description = "SKU for Ubuntu PRO 20.04 LTS"
  default     = "ubuntu-os-pro-cloud/ubuntu-pro-2004-lts"
}

variable "ubuntu_pro_2204_sku" {
  type        = string
  description = "SKU for Ubuntu PRO 20.04 LTS"
  default     = "ubuntu-os-pro-cloud/ubuntu-pro-2204-lts"
}

##############################
## GCP Linux VM - Variables ##
##############################

variable "linux_instance_type" {
  type        = string
  description = "VM instance type"
  default     = "f1-micro"
}

#############################
## Application - Variables ##
#############################

# company name
variable "company" {
  type        = string
  description = "This variable defines the company name used to build resources"
}

# application name
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# domain name
variable "app_domain" {
  type        = string
  description = "This variable defines the domain name used to build resources"
}

# environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}
