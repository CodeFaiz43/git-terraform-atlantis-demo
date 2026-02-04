#creating vpc
resource "google_compute_network" "vpc_network" {
  project                 = "tf-project-486307"
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Public Subnet
resource "google_compute_subnetwork" "public_subnet" {
  project       = "tf-project-486307"
  name          = "public-subnet"
  ip_cidr_range = "10.2.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

# Private Subnet
resource "google_compute_subnetwork" "private_subnet" {
  project       = "tf-project-486307"
  name          = "private-subnet"
  ip_cidr_range = "10.2.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

# Firewall rule for SSH to public VM and also ICMP protocol
resource "google_compute_firewall" "allow_ssh_bastion" {
  project = "tf-project-486307"
  name    = "allow-ssh-from-admin-2"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["firewall-rule-for-public-vm"]
}

# Firewall rule: allow SSH to private VM from inside VPC
resource "google_compute_firewall" "allow_ssh_private_vm" {
  project = "tf-project-486307"
  name    = "allow-ssh-private-vm"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.2.0.0/16"]
  target_tags   = ["firewall-rule-for-private-vm"]
}


# Public VM Instance
resource "google_compute_instance" "public_vm" {
  project      = "tf-project-486307"
  name         = "tf-vm-instance-01"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  # Network tags (for firewall rules to get applied)
  tags = ["firewall-rule-for-public-vm"]

  labels = {
    environment   = "dev"
    managed_by    = "terraform"
    team          = "platform"
    atlantis_test = "true"
  }

  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20260114"
      labels = {
        my_label = "value"
      }
    }
  }
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnet.id

    #this creates a public ip for VM
    access_config {}
  }

  # Metadata (for VM configuration)
  metadata = {
    environment = "dev"
    #keys for creating a user named faiz inside a VM
    ssh-keys = "faiz:${var.ssh_public_key}"
  }

  metadata_startup_script = "echo hello from terraform > /test.txt"

  #This is the identity the VM uses to talk to GCP APIs.
  service_account {
    scopes = ["cloud-platform"]
  }

  depends_on = [
    google_compute_network.vpc_network,
    google_compute_subnetwork.public_subnet
  ]
}

#creating a private vm
resource "google_compute_instance" "private_vm" {
  project      = "tf-project-486307"
  name         = "private-vm"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  # Network tags (for firewall rules to get applied)
  tags = ["firewall-rule-for-private-vm"]

  metadata = {
    ssh-keys = "faiz:${var.ssh_public_key}"
  }

  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20260114"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.id
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  depends_on = [
    google_compute_network.vpc_network,
    google_compute_subnetwork.private_subnet
  ]
}
