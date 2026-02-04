
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

PS C:\WINDOWS\system32> Set-Service ssh-agent -StartupType Automatic
PS C:\WINDOWS\system32> Start-Service ssh-agent
PS C:\WINDOWS\system32> Get-Service ssh-agent

Status   Name               DisplayName
------   ----               -----------
Running  ssh-agent          OpenSSH Authentication Agent

ssh-add "C:/Users/ws_htu769/Desktop/Cloud-Admin/gcp_with_terraform/gcp-vm-keys"


Login tointo public VM
ssh -A faiz@34.135.132.102

now from public VM we will login into private vm
faiz@tf-vm-instance-01:~$ ssh faiz@10.2.1.2
Linux private-vm 6.1.0-42-cloud-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.159-1 (2025-12-30) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Feb  4 05:17:28 2026 from 10.2.0.5

