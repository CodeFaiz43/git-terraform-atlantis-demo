Main Documentation Links:
1. VPC Networks Overview
https://cloud.google.com/vpc/docs/vpc Google Cloud
2. Subnets Documentation
https://cloud.google.com/vpc/docs/subnets Google Cloud
3. Create and Manage VPC Networks (Quickstart)
https://docs.cloud.google.com/vpc/docs/create-modify-vpc-networks Google
Key Points from Official Documentation:


terraform :

vpc : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network

subnet : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

vm : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

firewall : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall


############# Permission given to service account
network admin permission
 gcloud projects add-iam-policy-binding tf-project-486307 --member="serviceAccount:tf-service-account@cl-demo-dev-485906.iam.gserviceaccount.com" --role="roles/compute.networkAdmin"

compute instance permission
 gcloud projects add-iam-policy-binding tf-project-486307 --member="serviceAccount:tf-service-account@cl-demo-dev-485906.iam.gserviceaccount.com" --role="roles/compute.admin"

This allows your Terraform service account to use ANY service account in the project:
gcloud projects add-iam-policy-binding tf-project-486307 \
  --member="serviceAccount:tf-service-account@cl-demo-dev-485906.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"


https://console.cloud.google.com/apis/api/iam.googleapis.com/metrics?project=cl-demo-dev-485906


### **How It Works:**
```
Firewall Rule: "Allow SSH (port 22) from 0.0.0.0/0"
     ↓
target_tags = ["tf-demo-vpc-sub-vm"]  ← Looking for VMs with this tag
     ↓
Finds VM: "tf-vm-instance-01"
     ↓
VM has: tags = ["tf-demo-vpc-sub-vm"]  ← MATCH! ✅
     ↓
Firewall rule APPLIES to this VM