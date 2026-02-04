provider "google" {
    credentials = file("tf-service_account-key.json")
    project = "tf-project-486307"
}