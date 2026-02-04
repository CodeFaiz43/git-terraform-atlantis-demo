
gcloud compute networks list --project=tf-project-486307

1. VPC Network
gcloud compute networks list --project=tf-project-486307
See details of your VPC:
gcloud compute networks describe vpc-network --project=tf-project-486307

2. Subnets
gcloud compute networks subnets list --project=tf-project-486307
See details of your subnet:
gcloud compute networks subnets describe public-subnet --region=us-central1 --project=tf-project-486307

3. VM Instances
gcloud compute instances list --project=tf-project-486307


---- generating keys

ssh-keygen -t ed25519 -f C:\Users\ws_htu769\Desktop\Cloud-Admin\gcp_with_terraform\gcp-vm-keys

GCP automatically:
Creates user faiz on the VM
Adds key to:
/home/faiz/.ssh/authorized_keys


STEP 1 — Confirm public key on the PRIVATE VM (must do this)

gcloud compute instances describe private-vm --zone us-central1-a --format="get(metadata.items)"


C:\Program Files (x86)\Google\Cloud SDK>gcloud compute instances describe private-vm --zone us-central1-a --format="get(metadata.items)"
{'key': 'ssh-keys', 'value': 'faiz:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1T79LUmW8t2ijGZjzZajMAKIMASkb8wj69Qo87gzRY hoonartek03\\ws_htu769@HTWPUNLTP0584\r\n'}
